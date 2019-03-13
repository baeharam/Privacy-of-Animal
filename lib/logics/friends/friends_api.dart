import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/resources/strings.dart';

class FriendsAPI {

  // 친구정보 가져오기
  Future<List<DocumentSnapshot>> fetchFriendsList(List<dynamic> friends) async {
    List<DocumentSnapshot> friendsList = List<DocumentSnapshot>();
    if(friends.length==0) return friendsList;
    for(var user in friends) {
      DocumentSnapshot userInfo = await sl.get<FirebaseAPI>().getFirestore()
        .collection(firestoreUsersCollection)
        .document((user as DocumentSnapshot).documentID).get();
      friendsList.add(userInfo);
    }
    return friendsList;
  }

  // 친구 차단하기
  Future<void> blockFriends(String userToBlock) async {
    DocumentReference myselfDoc = sl.get<FirebaseAPI>().getFirestore().collection(firestoreUsersCollection)
      .document(sl.get<CurrentUser>().uid).collection(firestoreFriendsSubCollection).document(userToBlock);
    DocumentReference userToBlockDoc = sl.get<FirebaseAPI>().getFirestore().collection(firestoreUsersCollection)
      .document(userToBlock).collection(firestoreFriendsSubCollection).document(sl.get<CurrentUser>().uid);

    QuerySnapshot chatRoomSnapshot = await sl.get<FirebaseAPI>().getFirestore().collection(firestoreFriendsMessageCollection)
      .where(firestoreChatUsersField, arrayContains: userToBlock).getDocuments();

    WriteBatch batch = sl.get<FirebaseAPI>().getFirestore().batch();

    if(chatRoomSnapshot.documents.isNotEmpty) {
      DocumentReference realChatRoom;
      for(DocumentSnapshot doc in chatRoomSnapshot.documents) {
        if(doc.data[firestoreChatUsersField].contains(sl.get<CurrentUser>().uid)){
          realChatRoom = doc.reference;
          break;
        }
      }

      QuerySnapshot chatSnapshot = await realChatRoom
      .collection(realChatRoom.documentID)
      .getDocuments();

      for(DocumentSnapshot chat in chatSnapshot.documents) {
        batch.delete(chat.reference);
      }
      batch.delete(realChatRoom);
    }

    batch.delete(myselfDoc);
    batch.delete(userToBlockDoc);

    await batch.commit();
    if(sl.get<CurrentUser>().friendsListLength!=0) {
      sl.get<CurrentUser>().friendsListLength--;
    }
  }

  // 친구신청 수락하기
  // 친구 신청 목록에서 삭제 + 현재유저 친구목록에 넣기 + 신청유저 친구목록에 넣기 = 일괄작업 batch로
  Future<void> acceptFriendsRequest(String requestingUser) async {
    DocumentReference myselfDoc = sl.get<FirebaseAPI>().getFirestore().collection(firestoreUsersCollection)
      .document(sl.get<CurrentUser>().uid).collection(firestoreFriendsSubCollection).document(requestingUser);
    DocumentReference requestingUserDoc = sl.get<FirebaseAPI>().getFirestore().collection(firestoreUsersCollection)
      .document(requestingUser).collection(firestoreFriendsSubCollection).document(sl.get<CurrentUser>().uid);
    
    WriteBatch batch = sl.get<FirebaseAPI>().getFirestore().batch();

    batch.setData(myselfDoc, {firestoreFriendsField: true},merge: true);
    batch.setData(requestingUserDoc, {
      firestoreFriendsField: true,
      firestoreFriendsAccepted: true,
      firestoreFriendsUID: sl.get<CurrentUser>().uid
    });

    await batch.commit();
  }

  // 친구신청 삭제하기
  Future<void> rejectFriendsRequest(String requestingUser) async {
    DocumentReference doc = sl.get<FirebaseAPI>().getFirestore().collection(firestoreUsersCollection)
      .document(sl.get<CurrentUser>().uid).collection(firestoreFriendsSubCollection).document(requestingUser);
    await sl.get<FirebaseAPI>().getFirestore().runTransaction((tx) async{
      await tx.delete(doc);
    });
    sl.get<CurrentUser>().friendsRequestListLength--;
  }

  // 친구랑 대화하기
  // 1. 대화한 내용이 서버에 없으면 방을 생성한다.
  // 2. 대화한 내용이 서버에 있으면 해당 방에 입장한다.
  Future<String> chatWithFriends(String userToChat) async {
    QuerySnapshot snapshot = await sl.get<FirebaseAPI>().getFirestore().collection(firestoreFriendsMessageCollection)
      .where(firestoreChatUsersField, arrayContains: sl.get<CurrentUser>().uid).getDocuments();

    String chatRoomID = '';
    for(DocumentSnapshot doc in snapshot.documents) {
      if((doc.data[firestoreChatUsersField] as List).contains(userToChat)){
        chatRoomID = doc.documentID;
      }
    }

    if(chatRoomID.isEmpty) {
      DocumentReference doc = sl.get<FirebaseAPI>().getFirestore()
        .collection(firestoreFriendsMessageCollection)
        .document();
      await sl.get<FirebaseAPI>().getFirestore().runTransaction((tx) async{
        await tx.set(doc, {
          firestoreChatOutField: {
            sl.get<CurrentUser>().uid: Timestamp(0,0),
            userToChat: Timestamp(0,0)
          },
          firestoreChatDeleteField: {
            sl.get<CurrentUser>().uid: false,
            userToChat: false
          },
          firestoreChatUsersField: [userToChat, sl.get<CurrentUser>().uid]
        });
      });
      return doc.documentID;
    } else {
      return chatRoomID;
    }
  }

}