import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:flutter/services.dart';

class RandomChatAPI {

  // 현재 대기중인 방 중에 랜덤으로 찾기
  // 대기중인 방이 없으면 빈 문자열 리턴
  Future<String> getRoomID() async {
    QuerySnapshot snapshot = await sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreMessageCollection)
      .where(firestoreChatBeginField,isEqualTo: false).getDocuments();
    if(snapshot.documents.length==0){
      return '';
    } else {
      Random random = Random();
      DocumentSnapshot document = snapshot.documents[random.nextInt(snapshot.documents.length)];
      return document.documentID;
    }
  }

  // 대기중인 방이 없으면 방을 만들어야 됨
  Future<String> makeChatRoom() async {
    String autoChatRoomID = sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreMessageCollection)
      .document().documentID;
    DocumentReference document = sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreMessageCollection)
      .document(autoChatRoomID);
    
    sl.get<FirebaseAPI>().getFirestore().runTransaction((tx) async{
      try{
        await tx.set(document, {
          firestoreChatBeginField: false,
          firestoreChatUsersField: [sl.get<CurrentUser>().uid]
        });
      } catch(exception) {
        if(exception is PlatformException) {
          print(exception);
        } else {
          rethrow;
        }
      }
      
    });

    return autoChatRoomID;
  }

  // 대기중인 방이 있으면 그곳에 들어가서 flag 값을 true로 변경
  Future<void> enterChatRoom(String chatRoomID) async {
    DocumentReference document = sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreMessageCollection)
      .document(chatRoomID);
    
    sl.get<FirebaseAPI>().getFirestore().runTransaction((tx) async{
      try{
        await tx.update(document, {
          firestoreChatBeginField: true,
          firestoreChatUsersField: FieldValue.arrayUnion([sl.get<CurrentUser>().uid])
        });
      } catch(exception) {
        if(exception is PlatformException){
          print(exception);
        } else {
          rethrow;
        }
      }
    });
  }

  // 매칭을 하기 싫거나, 채팅 도중에 나갈 경우 채팅방이 삭제되어야 함.
  Future<void> deleteChatRoom(String chatRoomID) async {
    QuerySnapshot snapshot = await sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreMessageCollection)
      .where(firestoreChatUsersField, arrayContains: sl.get<CurrentUser>().uid).getDocuments();
    DocumentSnapshot document = snapshot.documents[0];
    sl.get<FirebaseAPI>().getFirestore().runTransaction((tx) async{
      try {
        await tx.delete(document.reference);
      } catch(exception){
        if(exception is PlatformException){
          print(exception);
        } else {
          rethrow;
        }
      }
    });
  }

  // 메시지 보내기
  Future<void> sendMessage(String content,String receiver,String chatRoomID) async {
    DocumentReference doc = sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreMessageCollection)
      .document(chatRoomID)
      .collection(chatRoomID)
      .document(DateTime.now().millisecondsSinceEpoch.toString());

    await sl.get<FirebaseAPI>().getFirestore().runTransaction((tx) async{
      try {
        await tx.set(doc,{
          'From': sl.get<CurrentUser>().uid,
          'To': receiver,
          'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
          'content': content
        });
      } catch(exception){
        if(exception is PlatformException){
          print(exception);
        } else {
          rethrow;
        }
      }
    });
  }
}