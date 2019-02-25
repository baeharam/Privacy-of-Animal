import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';

class RandomChatAPI {

  // 첫번째로 채팅방을 나갈 경우, delete 플래그를 true로 바꿔야 함.
  Future<void> getOutChatRoom(String chatRoomID) async {
    DocumentReference doc = sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreRandomMessageCollection)
      .document(chatRoomID);

    DocumentSnapshot snapshot = await doc.get();
    if(snapshot.data[firestoreChatOutField]==false) {
      sl.get<FirebaseAPI>().getFirestore().runTransaction((tx) async{
        await tx.update(doc, {firestoreChatOutField: true});
      });
    } else {
      await _deleteChatRoom(chatRoomID);
    }
  }

  // 두번째로 채팅방을 나가면 채팅방 삭제
  Future<void> _deleteChatRoom(String chatRoomID) async {
    DocumentSnapshot doc = await sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreRandomMessageCollection)
      .document(chatRoomID).get();
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

  // 메시지 보내기
  Future<void> sendMessage(String content,String receiver,String chatRoomID) async{
    DocumentReference doc = sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreRandomMessageCollection)
      .document(chatRoomID)
      .collection(chatRoomID)
      .document();

    await sl.get<FirebaseAPI>().getFirestore().runTransaction((tx) async{
      await tx.set(doc,{
        firestoreChatFromField: sl.get<CurrentUser>().uid,
        firestoreChatToField: receiver,
        firestoreChatTimestampField: FieldValue.serverTimestamp(),
        firestoreChatContentField: content
      });
    });
  }
}