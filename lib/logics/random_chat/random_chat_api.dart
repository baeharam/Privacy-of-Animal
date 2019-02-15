import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';

class RandomChatAPI {

  // 현재 대기중인 방 중에 랜덤으로 찾기
  // 대기중인 방이 없으면 빈 문자열 리턴
  Future<String> getRoomID() async {
    QuerySnapshot querySnapshot
      = await Firestore.instance.collection(firestoreMessageCollection)
        .where('begin',isEqualTo: false).getDocuments();

    if(querySnapshot.documents.length==0){
      return '';
    }
    Random random = Random();
    DocumentSnapshot document = querySnapshot.documents[random.nextInt(querySnapshot.documents.length)];
    return document.documentID;
  }

  // 대기중인 방이 없으면 방을 만들어야 됨
  Future<String> makeChatRoom() async {
    CollectionReference col = sl.get<FirebaseAPI>().getFirestore().collection(firestoreMessageCollection);
    DocumentReference doc;

    await sl.get<FirebaseAPI>().getFirestore().runTransaction((tx) async{
      doc = await col.add({
        firestoreChatBeginField: false,
        firestoreChatUsersField: [sl.get<CurrentUser>().uid]
      });
    });

    return doc.documentID;
  }

  // 대기중인 방이 있으면 그곳에 들어가서 flag 값을 true로 변경
  Future<String> enterChatRoom(String chatRoomID) async {
    DocumentReference document = sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreMessageCollection)
      .document(chatRoomID);
    
    await sl.get<FirebaseAPI>().getFirestore().runTransaction((tx) async{
      await document.updateData({
        firestoreChatBeginField: true,
        firestoreChatUsersField: FieldValue.arrayUnion([sl.get<CurrentUser>().uid])
      });
    });

    DocumentSnapshot doc = await document.get();
    return doc.data[firestoreChatUsersField][0];
  }

  // 매칭을 하기 싫거나, 채팅 도중에 나갈 경우 채팅방이 삭제되어야 함.
  Future<void> deleteChatRoom(String chatRoomID) async {
    QuerySnapshot snapshot = await sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreMessageCollection)
      .where(firestoreChatUsersField, arrayContains: sl.get<CurrentUser>().uid).getDocuments();

    await sl.get<FirebaseAPI>().getFirestore().runTransaction((tx) async{
      await snapshot.documents[0].reference.delete();
    });
  }

  // 첫번째로 채팅방을 나갈 경우, delete 플래그를 true로 바꿔야 함.
  Future<void> getOutChatRoom(String chatRoomID) async {
    DocumentReference doc = sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreMessageCollection)
      .document(chatRoomID);

    DocumentSnapshot snapshot = await doc.get();
    if(snapshot.data['delete']){
      await deleteChatRoom(chatRoomID);
    } else {
      await doc.setData({'delete': true});
    }
  }

  // 메시지 보내기
  Future<void> sendMessage(String content,String receiver,String chatRoomID) async {
    DocumentReference doc = sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreMessageCollection)
      .document(chatRoomID)
      .collection(chatRoomID)
      .document(DateTime.now().millisecondsSinceEpoch.toString());

    await sl.get<FirebaseAPI>().getFirestore().runTransaction((tx) async{
      await doc.setData({
        'From': sl.get<CurrentUser>().uid,
        'To': receiver,
        'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
        'content': content
      });
    });
  }
}