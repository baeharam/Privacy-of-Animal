import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:privacy_of_animal/logics/chat_list/chat_list.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/models/chat_list_model.dart';
import 'package:privacy_of_animal/models/user_model.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:rxdart/rxdart.dart';

class ChatListAPI {

  static Observable<QuerySnapshot> chatRoomListStream = Stream.empty();
  static PublishSubject<QuerySnapshot> chatRoomStreamController = PublishSubject();

  void connectToFirebase() {
    chatRoomListStream = sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreFriendsMessageCollection)
      .where('$firestoreChatDeleteField.${sl.get<CurrentUser>().uid}',isEqualTo: false)
      .snapshots();
    chatRoomListStream.listen((chatRoomList){
      chatRoomList.documents.map((chatRoom){
        Observable<QuerySnapshot> chatRoomStream = sl.get<FirebaseAPI>().getFirestore()
            .collection(firestoreFriendsMessageCollection)
            .document(chatRoom.documentID)
            .collection(chatRoom.documentID)
            .orderBy(firestoreChatTimestampField,descending: true)
            .limit(1)
            .snapshots();
        chatRoomStream.listen((snapshot) 
          => sl.get<ChatListBloc>().emitEvent(ChatListEventFetch(newMessage: snapshot.documents[0])));
        chatRoomStreamController.addStream(chatRoomStream);
      });
    });
  }

  Future<ChatListModel> fetchUserData(DocumentSnapshot newMessage) async {

    String uid = sl.get<CurrentUser>().uid.compareTo(newMessage.data[firestoreChatUsersField][0])==0
      ? newMessage.data[firestoreChatUsersField][1] 
      : newMessage.data[firestoreChatUsersField][0];
    DocumentSnapshot userData = await sl.get<FirebaseAPI>().getFirestore()
    .collection(firestoreUsersCollection)
    .document(uid).get();

    QuerySnapshot chatData = await newMessage.reference.collection(newMessage.documentID)
    .orderBy(firestoreChatTimestampField,descending: true).limit(1).getDocuments();

    return ChatListModel(
      chatRoomID: newMessage.documentID,
      profileImage: userData.data[firestoreFakeProfileField][firestoreAnimalImageField],
      nickName: userData.data[firestoreFakeProfileField][firestoreNickNameField],
      lastMessage: chatData.documents[0].data[firestoreChatContentField],
      lastTimestamp: chatData.documents[0].data[firestoreChatTimestampField],
      user: UserModel.fromSnapshot(snapshot: userData)
    );
  }

  // 채팅방 삭제
  // 1. 처음 사람이 삭제하는 경우 delete 플래그를 true로
  // 2. 두번째 사람이 삭제하는 경우는 delete 플래그가 true니까 아예 서버에서 삭제
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