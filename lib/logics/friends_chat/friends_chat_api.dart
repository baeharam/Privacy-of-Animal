import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:privacy_of_animal/logics/global/current_user.dart';
import 'package:privacy_of_animal/logics/global/database_api.dart';
import 'package:privacy_of_animal/logics/global/firebase_api.dart';
import 'package:privacy_of_animal/logics/global/notification_api.dart';
import 'package:privacy_of_animal/models/chat_model.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FriendsChatAPI {

    /// [처음 채팅 업데이트]
  Future<void> fetchFirstChat(String otherUserUID, List<DocumentSnapshot> chatList) async {
    debugPrint("[채팅] $otherUserUID와의 처음 채팅 업데이트");

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
    debugPrint('[채팅] $otherUserUID에게 채팅 보낼 때 로컬에 바로 업데이트');

    sl.get<CurrentUser>().chatHistory[otherUserUID].insert(0,chat);
  }

  /// [상대방에게 채팅 왔을 때 업데이트]
  void updateChatHistory(String otherUserUID, String nickName, QuerySnapshot snapshot) {
    debugPrint('[채팅] $otherUserUID에게 채팅 왔을 때 채팅 업데이트');

    sl.get<CurrentUser>().chatHistory[otherUserUID] ??= List<ChatModel>();

    for(DocumentChange chatData in snapshot.documentChanges) {
      sl.get<CurrentUser>().chatHistory[otherUserUID].insert(0,ChatModel.fromSnapshot(
        snapshot: chatData.document
      ));
      if(sl.get<CurrentUser>().chatRoomNotification[otherUserUID] &&
        sl.get<CurrentUser>().currentChatUID != otherUserUID) {
        sl.get<NotificationAPI>().showChatNotification(nickName, 
          chatData.document.data[firestoreChatContentField]);
      }
    }
  }

  /// [친구 알림 설정]
  Future<void> setChatRoomNotification(String otherUserUID) async {
    bool original = sl.get<CurrentUser>().chatRoomNotification[otherUserUID];
    debugPrint('[채팅] $otherUserUID의 채팅 알림을 $original에서 ${!original}로 변경');

    SharedPreferences prefs = await sl.get<DatabaseAPI>().sharedPreferences;
    bool value = !original;
    await prefs.setBool(otherUserUID, value);
    sl.get<CurrentUser>().chatRoomNotification[otherUserUID] = value;
  }
  
  /// [채팅 보내기]
  Future<void> sendMessage(String content,String receiver,String chatRoomID) async {
    debugPrint('[채팅] $receiver에게 채팅전송: $content');

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