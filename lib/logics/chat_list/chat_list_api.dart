import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/models/chat_list_model.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/resources/strings.dart';

class ChatListAPI {

  /// [채팅 삭제]
  void deleteChatHistory(String user) {
    sl.get<CurrentUser>().chatHistory.remove(user);
  }

  /// [채팅 추가]
  void addChatHistory(ChatListModel chat) {
    sl.get<CurrentUser>().chatHistory[chat.chatRoomID] = chat;
  }

  /// [채팅 삭제]
  Future<void> deleteChatRoom(String chatRoomID) async {
    DocumentSnapshot doc = await sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreFriendsMessageCollection)
      .document(chatRoomID).get();

    if(!doc.data[firestoreChatDeleteField][sl.get<CurrentUser>().uid]){
      await sl.get<FirebaseAPI>().getFirestore().runTransaction((tx) async{
        await tx.update(doc.reference, {
          '$firestoreChatDeleteField.${sl.get<CurrentUser>().uid}' : true,
          '$firestoreChatOutField.${sl.get<CurrentUser>().uid}' : FieldValue.serverTimestamp()
        });
      });
    } else {
      await sl.get<FirebaseAPI>().getFirestore().runTransaction((tx) async{
        QuerySnapshot forDelete = 
          await doc.reference.collection(doc.documentID)
          .getDocuments();
        for(DocumentSnapshot document in forDelete.documents) {
          await tx.delete(document.reference);
        }
        await tx.delete(doc.reference);
      });
    }
  }

}