import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:privacy_of_animal/logics/global/current_user.dart';
import 'package:privacy_of_animal/logics/global/firebase_api.dart';
import 'package:privacy_of_animal/logics/server/server_random_api.dart';
import 'package:privacy_of_animal/models/user_model.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';

class RandomLoadingAPI {

  void connectLoading() => sl.get<ServerRandomAPI>().connectRandomLoading();
  Future<void> disconnectLoading() async => await sl.get<ServerRandomAPI>().disconnectRandomLoading();

  // 현재 대기중인 방 중에 랜덤으로 찾기
  // 대기중인 방이 없으면 빈 문자열 리턴
  Future<String> getRoomID() async {
    debugPrint('[랜덤] 대기중인 방 찾는 중...');

    QuerySnapshot querySnapshot
      = await sl.get<FirebaseAPI>().getFirestore()
        .collection(firestoreRandomMessageCollection)
        .where(firestoreChatBeginField,isEqualTo: false)
        .getDocuments();
    if(querySnapshot.documents.isEmpty) {
      debugPrint('[랜덤] 대기중인 방 없음...');
      return '';
    }
    debugPrint('[랜덤] 대기중인 방 찾음!');
    Random random = Random();
    DocumentSnapshot document = querySnapshot.documents[random.nextInt(querySnapshot.documents.length)];
    return document.documentID;
  }

  // 대기중인 방이 없으면 방을 만들어야 됨
  Future<String> makeChatRoom() async {
    debugPrint('[랜덤] 방 생성...');

    CollectionReference col = sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreRandomMessageCollection);
    DocumentReference doc = col.document();

    await sl.get<FirebaseAPI>().getFirestore().runTransaction((tx) async{
      await tx.set(doc, {
        firestoreChatBeginField: false,
        firestoreChatUsersField: {sl.get<CurrentUser>().uid: true},
        firestoreChatOutField: false
      });
    });

    return doc.documentID;
  }

  // 대기중인 방이 있으면 그곳에 들어가서 flag 값을 true로 변경
  Future<UserModel> enterRoomAndGetUser(String chatRoomID) async {
    debugPrint('[랜덤] 방 입장!');

    DocumentReference document = sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreRandomMessageCollection)
      .document(chatRoomID);
    
    await sl.get<FirebaseAPI>().getFirestore().runTransaction((tx) async{
      await tx.update(document, {
        firestoreChatBeginField: true,
        '$firestoreChatUsersField.${sl.get<CurrentUser>().uid}': true
      });
    });

    DocumentSnapshot doc = await document.get();
    String receiver = '';
    (doc.data[firestoreChatUsersField] as Map).forEach((key,value){
      if(key!=sl.get<CurrentUser>().uid){
        receiver = key;
      }
    });

    return await fetchUserData(receiver);
  }

  // 사용자가 들어오면 해당 사용자에 대한 정보를 받아와야 함
  Future<UserModel> fetchUserData(String uid) async {
    debugPrint('[랜덤] 사용자 정보 가져오기');

    DocumentSnapshot snapshot = await sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreUsersCollection)
      .document(uid)
      .get();
    return UserModel.fromSnapshot(snapshot: snapshot);
  }

  // 만든 채팅방 삭제
  Future<void> deleteMadeChatRoom() async {
    debugPrint('[랜덤] 만든 채팅방 삭제!');

    QuerySnapshot snapshot = await sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreRandomMessageCollection)
      .where('$firestoreChatUsersField.${sl.get<CurrentUser>().uid}', isEqualTo: true)
      .where(firestoreChatBeginField,isEqualTo:false)
      .getDocuments();

    await sl.get<FirebaseAPI>().getFirestore().runTransaction((tx) async{
      await tx.delete(snapshot.documents[0].reference);
    });
  }
}