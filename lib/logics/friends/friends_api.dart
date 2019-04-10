import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/database_helper.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/logics/notification_helper.dart';
import 'package:privacy_of_animal/logics/other_profile/other_profile.dart';
import 'package:privacy_of_animal/logics/same_match/same_match.dart';
import 'package:privacy_of_animal/models/chat_list_model.dart';
import 'package:privacy_of_animal/models/chat_model.dart';
import 'package:privacy_of_animal/models/user_model.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FriendsAPI {

  String _uid;
  UserModel _notifyingFriends, _notifyingRequestFrom;
  
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

  /// [처음 친구 업데이트]
  Future<void> fetchFirstFriends(List<DocumentSnapshot> friendsList) async {
    debugPrint("처음 친구 업데이트");

    for(DocumentSnapshot friends in friendsList) {
      DocumentSnapshot friendsSnapshot = await sl.get<FirebaseAPI>().getFirestore()
        .collection(firestoreUsersCollection)
        .document(friends.documentID)
        .get();
      UserModel friendsUserModel = UserModel.fromSnapshot(snapshot: friendsSnapshot);
      _increaseLocalFriends(friendsUserModel);
    }
  }

  /// [처음 친구신청 업데이트]
  Future<void> fetchFirstRequest(List<DocumentSnapshot> requestList) async {
    debugPrint("처음 친구신청 업데이트");

    for(DocumentSnapshot request in requestList) {
      DocumentSnapshot requestSnapshot = await sl.get<FirebaseAPI>().getFirestore()
        .collection(firestoreUsersCollection)
        .document(request.documentID)
        .get();
      UserModel requestUserModel = UserModel.fromSnapshot(snapshot: requestSnapshot);
      _increaseLocalRequest(requestUserModel);
    }
  }

  /// [친구 증가]
  Future<void> fetchIncreasedFriends(List<DocumentChange> newFriendsList) async {
    debugPrint("친구 증가했을 때 데이터 가져오기");

    _setNewFriendsNum(newFriendsList.length);

    for(DocumentChange newFriends in newFriendsList) {
      debugPrint("${newFriends.document.documentID}, IsAccepted: ${newFriends.document.data[firestoreFriendsAccepted]}");
      DocumentSnapshot newFriendsSnapshot = await sl.get<FirebaseAPI>().getFirestore()
        .collection(firestoreUsersCollection)
        .document(newFriends.document.documentID)
        .get();
      UserModel newFriendsUserModel =UserModel.fromSnapshot(snapshot: newFriendsSnapshot);
      _increaseLocalFriends(newFriendsUserModel);
      _updateOtherProfileFriends(newFriendsUserModel.uid);
      if(newFriends.document.data[firestoreFriendsAccepted]) {
        _notifyingFriends ??= newFriendsUserModel;
      }
    }
  }

  void _setNewFriendsNum(int num) {
    sl.get<CurrentUser>().newFriendsNum = num;
  }

  void _updateOtherProfileFriends(String otherUserUID) {
    if(otherUserUID == sl.get<CurrentUser>().currentProfileUID) {
      debugPrint("프로필 화면과 매칭화면 업데이트");

      sl.get<SameMatchBloc>().emitEvent(SameMatchEventRefreshFriends());
      sl.get<OtherProfileBloc>().emitEvent(OtherProfileEventRefreshFriends());
    }
  }

  void notifyNewFriends() {
    if(_notifyingFriends!=null && sl.get<CurrentUser>().friendsNotification) {
      debugPrint("새로운 친구 알림");

      sl.get<NotificationHelper>().showFriendsNotification(_notifyingFriends.fakeProfileModel.nickName);
      _notifyingFriends = null;
    }
  }

  /// [친구 감소]
  Future<void> fetchDecreasedFriends(List<DocumentChange> deletedFriendsList) async {
    debugPrint("친구 감소했을 때 데이터 가져오기");

    for(DocumentChange deletedFriends in deletedFriendsList) {
      String deletedFriendsUID = deletedFriends.document.documentID;
      DocumentSnapshot deletedFriendsSnapshot = await sl.get<FirebaseAPI>().getFirestore()
        .collection(firestoreUsersCollection)
        .document(deletedFriendsUID).get();
      UserModel deletedFriendsUserModel = UserModel.fromSnapshot(snapshot: deletedFriendsSnapshot);
      await _decreaseLocalFriends(deletedFriendsUserModel);
      _updateOtherProfileFriends(deletedFriendsUID);
    }
  }

  /// [받은 친구신청 증가]
  Future<void> fetchIncreasedRequestFrom(List<DocumentChange> newRequestFromList) async {
    debugPrint("친구신청 증가했을 때 데이터 가져오기");

    for(DocumentChange newRequestFrom in newRequestFromList) {
      DocumentSnapshot newRequestFromSnapshot = await sl.get<FirebaseAPI>().getFirestore()
        .collection(firestoreUsersCollection)
        .document(newRequestFrom.document.documentID)
        .get();
      UserModel newRequestFromUserModel =UserModel.fromSnapshot(snapshot: newRequestFromSnapshot);
      _increaseLocalRequest(newRequestFromUserModel);
      _updateOtherProfileRequest(newRequestFromUserModel.uid);
      _notifyingRequestFrom ??= newRequestFromUserModel;
    }
  }

  void _updateOtherProfileRequest(String otherUserUID) {
    if(otherUserUID == sl.get<CurrentUser>().currentProfileUID) {
      debugPrint("프로필 화면과 매칭 화면 업데이트");

      sl.get<SameMatchBloc>().emitEvent(SameMatchEventRefreshRequestFrom());
      sl.get<OtherProfileBloc>().emitEvent(OtherProfileEventRefreshRequestFrom());
    }
  }

  void notifyNewRequestFrom() {
    if(sl.get<CurrentUser>().friendsNotification && _notifyingRequestFrom!=null) {
      debugPrint("새로운 친구신청 알림");

      sl.get<NotificationHelper>().showRequestNotification(_notifyingRequestFrom.fakeProfileModel.nickName);
      _notifyingRequestFrom = null;
    }
  }

  /// [친구신청 감소]
  Future<void> fetchDecreasedRequestFrom(List<DocumentChange> deletedRequestFromList) async {
    debugPrint("친구신청 감소했을 때 데이터 가져오기");

    for(DocumentChange deletedRequestFrom in deletedRequestFromList) {
      String deletedRequestFromUID = deletedRequestFrom.document.documentID;
      DocumentSnapshot deletedRequestSnapshot = await sl.get<FirebaseAPI>().getFirestore()
        .collection(firestoreUsersCollection)
        .document(deletedRequestFromUID)
        .get();
      UserModel deletedRequestUserModel = UserModel.fromSnapshot(snapshot: deletedRequestSnapshot);
      _decreaseLocalRequest(deletedRequestUserModel);
      _updateOtherProfileRequest(deletedRequestFromUID);
    }
  }


  /// [서버에서 친구 차단]
  Future<void> blockFriendsForServer(UserModel userToBlock) async {
    debugPrint("서버에서 친구 차단");

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

  /// [서버에서 친구신청 수락]
  Future<void> acceptFriendsForServer(UserModel requestFromingUser) async {
    debugPrint("서버에서 친구 수락");

    // 먼저 친구신청란에서 지워야 함
    sl.get<CurrentUser>().requestFromList.remove(requestFromingUser);

    String currentUser = _uid;

    DocumentReference myselfDoc = sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreUsersCollection)
      .document(currentUser)
      .collection(firestoreFriendsSubCollection)
      .document(requestFromingUser.uid);

    DocumentReference requestFromingUserDoc = sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreUsersCollection)
      .document(requestFromingUser.uid)
      .collection(firestoreFriendsSubCollection)
      .document(currentUser);

    DocumentReference chatDoc = sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreFriendsMessageCollection)
      .document();
    
    WriteBatch batch = sl.get<FirebaseAPI>().getFirestore().batch();

    batch.setData(myselfDoc, {firestoreFriendsField: true},merge: true);
    batch.setData(requestFromingUserDoc, {
      firestoreFriendsField: true,
      firestoreFriendsAccepted: true,
      firestoreFriendsUID: currentUser
    });

    batch.setData(chatDoc, {
      firestoreChatOutField: {
        currentUser: Timestamp(0,0),
        requestFromingUser.uid: Timestamp(0,0)
      },
      firestoreChatDeleteField: {
        currentUser: false,
        requestFromingUser.uid: false
      },
      firestoreChatUsersField: {
        currentUser: true,
        requestFromingUser.uid: true
      }
    });

    await batch.commit();
  }

  /// [서버에서 친구신청 삭제]
  Future<void> rejectFriendsForServer(UserModel userToReject) async {
    debugPrint("서버에서 친구신청 삭제");

    DocumentReference doc = sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreUsersCollection)
      .document(_uid)
      .collection(firestoreFriendsSubCollection)
      .document(userToReject.uid);
    await sl.get<FirebaseAPI>().getFirestore().runTransaction((tx) async{
      await tx.delete(doc);
    });
  }

  /// [친구와 대화]
  Future<String> chatWithFriends(String userToChat) async {
    debugPrint("친구와 대화");

    sl.get<CurrentUser>().chatListHistory[userToChat] ??= ChatListModel();
    sl.get<CurrentUser>().chatHistory[userToChat] ??= List<ChatModel>();

    if(sl.get<CurrentUser>().chatListHistory[userToChat].chatRoomID.isEmpty) {
      QuerySnapshot chatRoomSnapshot = await sl.get<FirebaseAPI>().getFirestore()
        .collection(firestoreFriendsMessageCollection)
        .where('$firestoreChatUsersField.${sl.get<CurrentUser>().uid}',isEqualTo: true)
        .where('$firestoreChatUsersField.$userToChat',isEqualTo: true)
        .getDocuments();
      sl.get<CurrentUser>().chatListHistory[userToChat].chatRoomID 
        = chatRoomSnapshot.documents[0].documentID;
    }

    return sl.get<CurrentUser>().chatListHistory[userToChat].chatRoomID;
  }

  /// [로컬에서 친구 감소]
  Future<void> _decreaseLocalFriends(UserModel userToBlock) async{
    debugPrint("친구 감소했을 때 로컬에서 업데이트");

    SharedPreferences prefs = await sl.get<DatabaseHelper>().sharedPreferences;
    prefs.remove(userToBlock.uid);

    sl.get<CurrentUser>().friendsList.removeWhere((friends) => friends.uid==userToBlock.uid);
    sl.get<CurrentUser>().chatHistory.remove(userToBlock.uid);
    sl.get<CurrentUser>().chatListHistory.remove(userToBlock.uid);
    sl.get<CurrentUser>().chatRoomNotification.remove(userToBlock.uid);
  }

  /// [로컬에서 친구 증가]
  Future<void> _increaseLocalFriends(UserModel newFriends) async{
    debugPrint("친구 증가했을 때 로컬에서 업데이트");

    SharedPreferences prefs = await sl.get<DatabaseHelper>().sharedPreferences;
    prefs.setBool(newFriends.uid, true);

    sl.get<CurrentUser>().friendsList.add(newFriends);
    sl.get<CurrentUser>().chatHistory[newFriends.uid] = [];
    sl.get<CurrentUser>().chatRoomNotification[newFriends.uid] = true;
  } 

  /// [로컬에서 친구신청 감소]
  void _decreaseLocalRequest(UserModel userToReject) {
    debugPrint("친구신청 감소했을 때 로컬에서 업데이트");

    sl.get<CurrentUser>().requestFromList
      .removeWhere((requestingUser)=>requestingUser.uid==userToReject.uid);
  }

  /// [로컬에서 친구신청 증가]
  void _increaseLocalRequest(UserModel requestingUser) {
    debugPrint("친구신청 증가했을 때 로컬에서 업데이트");

    sl.get<CurrentUser>().requestFromList.add(requestingUser);
  }
}