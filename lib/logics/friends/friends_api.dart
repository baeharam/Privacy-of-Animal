import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/database_helper.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/logics/notification_helper.dart';
import 'package:privacy_of_animal/models/chat_list_model.dart';
import 'package:privacy_of_animal/models/user_model.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FriendsAPI {

  String _uid;
  UserModel _notifyingFriends, _notifyingRequest;
  
  FriendsAPI() {
    _uid = sl.get<CurrentUser>().uid;
    assert(_uid!=null, '사용자 UID 초기화 실패');
  } 

  /// [친구 알림 설정]
  Future<void> setFriendsNotification() async {
    SharedPreferences prefs = await sl.get<DatabaseHelper>().sharedPreferences;
    bool value = !sl.get<CurrentUser>().friendsNotification;
    prefs.setBool(_uid+friendsNotification, value);
    sl.get<CurrentUser>().friendsNotification = value;
  }

  /// [친구 증가]
  Future<void> fetchIncreasedFriends(List<DocumentChange> newFriendsList) async {
    for(DocumentChange newFriends in newFriendsList) {
      DocumentSnapshot newFriendsSnapshot = await sl.get<FirebaseAPI>().getFirestore()
        .collection(firestoreUsersCollection)
        .document(newFriends.document.documentID)
        .get();
      UserModel newFriendsUserModel =UserModel.fromSnapshot(snapshot: newFriendsSnapshot);
      sl.get<CurrentUser>().friendsList.add(newFriendsUserModel);
      _notifyingFriends ??=newFriendsUserModel;
    }
  }

  void notifyNewFriends() {
    if(sl.get<CurrentUser>().friendsNotification) {
      sl.get<NotificationHelper>().showFriendsNotification(_notifyingFriends.fakeProfileModel.nickName);
    }
  }

  /// [친구 감소]
  Future<void> fetchDecreasedFriends(List<DocumentChange> deletedFriendsList) async {
    for(DocumentChange deletedFriends in deletedFriendsList) {
      String deletedFriendsUID = deletedFriends.document.documentID;
      sl.get<CurrentUser>().friendsList.removeWhere((friendsModel) => friendsModel.uid==deletedFriendsUID);
    }
  }

  /// [친구신청 증가]
  Future<void> fetchIncreasedRequest(List<DocumentChange> newRequestList) async {
    for(DocumentChange newRequest in newRequestList) {
      DocumentSnapshot newRequestSnapshot = await sl.get<FirebaseAPI>().getFirestore()
        .collection(firestoreUsersCollection)
        .document(newRequest.document.documentID)
        .get();
      UserModel newRequestUserModel =UserModel.fromSnapshot(snapshot: newRequestSnapshot);
      sl.get<CurrentUser>().requestList.add(newRequestUserModel);
      _notifyingRequest ??= newRequestUserModel;
    }
  }

  void notifyNewRequest() {
    if(sl.get<CurrentUser>().friendsNotification) {
      sl.get<NotificationHelper>().showRequestNotification(_notifyingRequest.fakeProfileModel.nickName);
    }
  }

  /// [친구신청 감소]
  Future<void> fetchDecreasedRequest(List<DocumentChange> deletedRequestList) async {
    for(DocumentChange deletedRequest in deletedRequestList) {
      String deletedRequestUID = deletedRequest.document.documentID;
      sl.get<CurrentUser>().requestList.removeWhere((requestModel) => requestModel.uid==deletedRequestUID);
    }
  }


  /// [서버에서 친구 차단]
  Future<void> blockFriendsForServer(UserModel userToBlock) async {

    DocumentReference myselfDoc = sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreUsersCollection)
      .document(_uid)
      .collection(firestoreFriendsSubCollection)
      .document(userToBlock.uid);

    DocumentReference userToBlockDoc = sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreUsersCollection)
      .document(userToBlock.uid)
      .collection(firestoreFriendsSubCollection)
      .document(_uid);
      
    QuerySnapshot chatRoomSnapshot = await sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreFriendsMessageCollection)
      .where('$firestoreChatUsersField.$_uid', isEqualTo: true)
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
  }

  /// [로컬에서 친구 차단]
  void blockFriendsForLocal(UserModel userToBlock) {
    sl.get<CurrentUser>().friendsList.remove(userToBlock);
    sl.get<CurrentUser>().chatHistory.remove(userToBlock.uid);
    sl.get<CurrentUser>().chatListHistory.remove(userToBlock.uid);
    sl.get<CurrentUser>().chatRoomNotification.remove(userToBlock.uid);
  }

  /// [서버에서 친구신청 수락]
  Future<void> acceptFriendsForServer(UserModel requestingUser) async {

    String currentUser = _uid;

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
  }

  /// [로컬에서 친구신청 수락]
  Future<void> acceptFriendsForLocal(UserModel requestingUser) async{
    SharedPreferences prefs = await sl.get<DatabaseHelper>().sharedPreferences;
    prefs.setBool(requestingUser.uid+chatNotification, true);

    sl.get<CurrentUser>().requestList.remove(requestingUser);
    sl.get<CurrentUser>().chatHistory[requestingUser.uid] = [];
    sl.get<CurrentUser>().chatListHistory[requestingUser.uid] = ChatListModel();
    sl.get<CurrentUser>().chatRoomNotification[requestingUser.uid] = true;
  } 

  /// [서버에서 친구신청 삭제]
  Future<void> rejectFriendsForServer(UserModel userToReject) async {
    DocumentReference doc = sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreUsersCollection)
      .document(_uid)
      .collection(firestoreFriendsSubCollection)
      .document(userToReject.uid);
    await sl.get<FirebaseAPI>().getFirestore().runTransaction((tx) async{
      await tx.delete(doc);
    });
  }

  /// [로컬에서 친구신청 삭제]
  void rejectFriendsForLocal(UserModel userToReject) {
    sl.get<CurrentUser>().requestList.remove(userToReject);
  }

  /// [친구와 대화]
  Future<String> chatWithFriends(String userToChat) async {
    String currentUser = _uid;

    QuerySnapshot snapshot = await sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreFriendsMessageCollection)
      .where('$firestoreChatUsersField.$currentUser',isEqualTo: true)
      .where('$firestoreChatUsersField.$userToChat',isEqualTo: true)
      .getDocuments();

    String chatRoomID = snapshot.documents[0].documentID;
    sl.get<CurrentUser>().chatRoomNotification[chatRoomID] = true;
    sl.get<CurrentUser>().chatHistory[userToChat] = [];

    return snapshot.documents[0].documentID;
  }
}