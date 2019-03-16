import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/logics/server_api.dart';
import 'package:privacy_of_animal/models/user_model.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/resources/strings.dart';

class FriendsAPI {

  /// [친구목록] 및 [친구신청 목록] 가져오기
  Future<void> fetchFriendsList(List<dynamic> friends, {@required bool isFriendsList}) async {
    print("Update Friends List");
    List<UserModel> userList = List<UserModel>();
    if(friends.isNotEmpty) {
      for(var user in friends) {
        DocumentSnapshot userInfo = await sl.get<FirebaseAPI>().getFirestore()
          .collection(firestoreUsersCollection)
          .document((user as DocumentSnapshot).documentID).get();
        userList.add(UserModel.fromSnapshot(snapshot: userInfo));
      }
    }
    if(isFriendsList) {
      sl.get<CurrentUser>().friendsList = userList;
    } else {
      sl.get<CurrentUser>().friendsRequestList = userList;
    }
  }

  /// [친구 삭제]
  Future<void> blockFriends(UserModel userToBlock) async {
    String currentUser = sl.get<CurrentUser>().uid;

    DocumentReference myselfDoc = sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreUsersCollection)
      .document(currentUser)
      .collection(firestoreFriendsSubCollection)
      .document(userToBlock.uid);

    DocumentReference userToBlockDoc = sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreUsersCollection)
      .document(userToBlock.uid)
      .collection(firestoreFriendsSubCollection)
      .document(currentUser);

    QuerySnapshot chatRoomSnapshot = await sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreFriendsMessageCollection)
      .where('$firestoreChatUsersField.$currentUser', isEqualTo: true)
      .where('$firestoreChatUsersField.${userToBlock.uid}', isEqualTo: true)
      .getDocuments();

    WriteBatch batch = sl.get<FirebaseAPI>().getFirestore().batch();

    if(chatRoomSnapshot.documents.isNotEmpty) {
      DocumentReference realChatRoom =chatRoomSnapshot.documents[0].reference;

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

    sl.get<CurrentUser>().friendsList.remove(userToBlock);

    _cancelOtherUser(userToBlock.uid);
  }

  /// [친구신청 수락]
  Future<void> acceptFriendsRequest(UserModel requestingUser) async {

    String currentUser = sl.get<CurrentUser>().uid;

    DocumentReference myselfDoc = sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreUsersCollection)
      .document(currentUser)
      .collection(firestoreFriendsSubCollection)
      .document(requestingUser.uid);

    DocumentReference requestingUserDoc = sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreUsersCollection)
      .document(requestingUser.uid)
      .collection(firestoreFriendsSubCollection)
      .document(currentUser);

    DocumentReference chatDoc = sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreFriendsMessageCollection)
      .document();
    
    WriteBatch batch = sl.get<FirebaseAPI>().getFirestore().batch();

    batch.setData(myselfDoc, {firestoreFriendsField: true},merge: true);
    batch.setData(requestingUserDoc, {
      firestoreFriendsField: true,
      firestoreFriendsAccepted: true,
      firestoreFriendsUID: currentUser
    });

    batch.setData(chatDoc, {
      firestoreChatOutField: {
        currentUser: Timestamp(0,0),
        requestingUser.uid: Timestamp(0,0)
      },
      firestoreChatDeleteField: {
        currentUser: false,
        requestingUser.uid: false
      },
      firestoreChatUsersField: {
        currentUser: true,
        requestingUser.uid: true
      }
    });

    await batch.commit();
    sl.get<CurrentUser>().friendsRequestList.remove(requestingUser);
    await _listenOtherUser(requestingUser);
  }

  /// [친구신청 삭제]
  Future<void> rejectFriendsRequest(UserModel requestingUser) async {
    DocumentReference doc = sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreUsersCollection)
      .document(sl.get<CurrentUser>().uid)
      .collection(firestoreFriendsSubCollection)
      .document(requestingUser.uid);
    await sl.get<FirebaseAPI>().getFirestore().runTransaction((tx) async{
      await tx.delete(doc);
    });
    sl.get<CurrentUser>().friendsRequestList.remove(requestingUser);
  }

  /// [친구와 대화]
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

  void _cancelOtherUser(String userToBlock) {
    sl.get<ServerAPI>().disconnectChatRoom(otherUserUID: userToBlock);
  }

  Future<void> _listenOtherUser(UserModel requestingUser) async{
    sl.get<ServerAPI>().connectChatRoom(otherUser: requestingUser);
  }
}