import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/database_helper.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/logics/notification_helper.dart';
import 'package:privacy_of_animal/models/chat_model.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FriendsChatAPI {

    /// [처음 채팅 업데이트]
  Future<void> fetchFirstChat(String otherUserUID, List<DocumentSnapshot> chatList) async {
    debugPrint("처음 채팅 업데이트");

    sl.get<CurrentUser>().chatHistory[otherUserUID] ??= List<ChatModel>();
    
    for(DocumentSnapshot chat in chatList) {
      ChatModel chatModel = new ChatModel();
      chatModel.from = chat.data[firestoreChatFromField];
      chatModel.to = chat.data[firestoreChatToField];
      chatModel.content = chat.data[firestoreChatContentField];
      chatModel.timeStamp = chat.data[firestoreChatTimestampField];
      sl.get<CurrentUser>().chatHistory[otherUserUID].add(chatModel);
    }
  }

  /// [내가 채팅 보냈을 때 업데이트]
  void addChatDirectly(String otherUserUID, ChatModel chat) {
    sl.get<CurrentUser>().chatHistory[otherUserUID].insert(0,chat);
  }

  /// [상대방에게 채팅 왔을 때 업데이트]
  void updateChatHistory(String otherUserUID, String nickName, QuerySnapshot snapshot) {
    sl.get<CurrentUser>().chatHistory[otherUserUID] ??= List<ChatModel>();

    for(DocumentChange chatData in snapshot.documentChanges) {
      sl.get<CurrentUser>().chatHistory[otherUserUID].insert(0,ChatModel.fromSnapshot(
        snapshot: chatData.document
      ));
      if(sl.get<CurrentUser>().chatRoomNotification[otherUserUID] &&
        sl.get<CurrentUser>().currentChatUID != otherUserUID) {
        sl.get<NotificationHelper>().showChatNotification(nickName, 
          chatData.document.data[firestoreChatContentField]);
      }
    }
  }

  /// [친구 알림 설정]
  Future<void> setChatRoomNotification(String otherUserUID) async {
    SharedPreferences prefs = await sl.get<DatabaseHelper>().sharedPreferences;
    bool value = !sl.get<CurrentUser>().chatRoomNotification[otherUserUID];
    prefs.setBool(otherUserUID, value);
    sl.get<CurrentUser>().chatRoomNotification[otherUserUID] = value;
  }
  
  /// [채팅 보내기]
  Future<void> sendMessage(String content,String receiver,String chatRoomID) async {
    DocumentSnapshot flagDoc = await sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreFriendsMessageCollection)
      .document(chatRoomID)
      .get();

    DocumentReference chatDoc = sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreFriendsMessageCollection)
      .document(chatRoomID)
      .collection(chatRoomID)
      .document();

    await sl.get<FirebaseAPI>().getFirestore().runTransaction((tx) async{
      await tx.update(flagDoc.reference, {
        '$firestoreChatDeleteField.$receiver': false,
        '$firestoreChatDeleteField.${sl.get<CurrentUser>().uid}': false
      });
    });

    await sl.get<FirebaseAPI>().getFirestore().runTransaction((tx) async{
      await tx.set(chatDoc, {
        firestoreChatFromField: sl.get<CurrentUser>().uid,
        firestoreChatToField: receiver,
        firestoreChatContentField: content,
        firestoreChatTimestampField: FieldValue.serverTimestamp()
      });
    });
  }
}