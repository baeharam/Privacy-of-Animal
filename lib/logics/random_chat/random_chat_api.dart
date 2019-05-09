import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:privacy_of_animal/logics/global/current_user.dart';
import 'package:privacy_of_animal/logics/global/firebase_api.dart';
import 'package:privacy_of_animal/logics/server/server_random_api.dart';
import 'package:privacy_of_animal/models/chat_model.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';

class RandomChatAPI {

  /// [내가 채팅 보냈을 때 업데이트]
  void addChatDirectly(String otherUserUID, ChatModel chat) {
    sl.get<CurrentUser>().randomChat.insert(0,chat);
  }

  /// [매칭된 랜덤 채팅방 연결]
  void connectRandomChat(String chatRoomID, String otherUserUID) {
    sl.get<ServerRandomAPI>().connectRandomChat(chatRoomID);
    sl.get<ServerRandomAPI>().connectRandomChatOut(otherUserUID);
  }

  /// [매칭된 랜덤 채팅방 해제]
  Future<void> disconnectRandomChat() async {
    await sl.get<ServerRandomAPI>().disconnectRandomChat();
    await sl.get<ServerRandomAPI>().disconnectRandomChatOut();
  }

  /// [스냅샷을 통해 채팅 가공]
  Future<void> processChatSnapshot(QuerySnapshot chatSnapshot) async {
    chatSnapshot.documentChanges.forEach((chat){
      if(chat.document.data[firestoreChatFromField]!=sl.get<CurrentUser>().uid){
        sl.get<CurrentUser>().randomChat
          .insert(0,ChatModel.fromSnapshot(snapshot: chat.document));
      }
    });
  }

  /// [첫번째로 채팅방을 나갈 경우, delete 플래그를 true로 바꿔야 함].
  Future<void> getOutChatRoom(String chatRoomID) async {
    DocumentReference doc = sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreRandomMessageCollection)
      .document(chatRoomID);

    DocumentSnapshot snapshot = await doc.get();
    if(snapshot.data[firestoreChatOutField]==false) {
      await sl.get<FirebaseAPI>().getFirestore().runTransaction((tx) async{
        await tx.update(doc, {firestoreChatOutField: true});
      });
    } else {
      await _deleteChatRoom(chatRoomID);
    }
  }

  /// [두번째로 채팅방을 나가면 채팅방 삭제]
  Future<void> _deleteChatRoom(String chatRoomID) async {
    DocumentSnapshot doc = await sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreRandomMessageCollection)
      .document(chatRoomID).get();
    QuerySnapshot forDelete = await doc.reference.collection(doc.documentID)
      .getDocuments();
    
    WriteBatch batch = sl.get<FirebaseAPI>().getFirestore().batch();

    for(DocumentSnapshot document in forDelete.documents) {
      batch.delete(document.reference);
    }
    batch.delete(doc.reference);
    
    await batch.commit();
  }

  /// [메시지 보내기]
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