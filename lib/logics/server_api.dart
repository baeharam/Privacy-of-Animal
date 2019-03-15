import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/models/chat_list_model.dart';
import 'package:privacy_of_animal/models/user_model.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:privacy_of_animal/resources/strings.dart';

class ServerAPI {

  var chatRoomListServer = Map<String, Observable<QuerySnapshot>>();
  var chatRoomListSubscriptions = Map<String, StreamSubscription<QuerySnapshot>>();

  Observable<QuerySnapshot> friendsListServer;
  StreamSubscription friendsListSubscription;

  Observable<QuerySnapshot> friendsRequestListServer;
  StreamSubscription friendsRequestListSubscription;

  /// [로그인 → 친구목록 연결]
  Future<void> connectFriendsList() async {
    friendsListServer = Observable(sl.get<FirebaseAPI>().getFirestore()
        .collection(firestoreUsersCollection).document(sl.get<CurrentUser>().uid)
        .collection(firestoreFriendsSubCollection).where(firestoreFriendsField, isEqualTo: true)
        .snapshots());
    friendsListSubscription = friendsListServer.listen((snapshot) {
      if(snapshot.documentChanges.isNotEmpty) {

        // 각 친구의 대화방 연결
        snapshot.documentChanges.map((change) async{
          await connectChatRoom(otherUser: UserModel.fromSnapshot(snapshot: change.document));
        });


        // 친구목록 캐싱
        List<UserModel> friendsList = List<UserModel>();
        snapshot.documents.map((friends){
          friendsList.add(UserModel.fromSnapshot(snapshot: friends));
        });
        sl.get<CurrentUser>().friendsList = friendsList;
      }
    });
  }

  /// [로그아웃 → 친구목록 해제]
  Future<void> disconnectFriendsList() async {
    await friendsListSubscription.cancel();
  }

  /// [로그인 → 친구신청목록 연결]
  Future<void> connectFriendsRequestList() async {
    friendsRequestListServer = Observable(sl.get<FirebaseAPI>().getFirestore()
        .collection(firestoreUsersCollection).document(sl.get<CurrentUser>().uid)
        .collection(firestoreFriendsSubCollection).where(firestoreFriendsField, isEqualTo: false)
        .snapshots());
    friendsRequestListSubscription = friendsRequestListServer.listen((snapshot) {
      if(snapshot.documentChanges.isNotEmpty) {
        List<UserModel> friendsRequestList = List<UserModel>();
        snapshot.documents.map((friends){
          friendsRequestList.add(UserModel.fromSnapshot(snapshot: friends));
        });
        sl.get<CurrentUser>().friendsRequestList = friendsRequestList;
      }
    });
  }

  /// [로그아웃 → 친구신청목록 해제]
  Future<void> disconnectFriendsRequestList() async {
    await friendsRequestListSubscription.cancel();
  }


  /// [친구수락 → 채팅방 연결]
  Future<void> connectChatRoom({@required UserModel otherUser}) async{

    String chatRoomID = await _getChatRoomID(otherUser.uid);

    chatRoomListServer[otherUser.uid] = Observable(
      sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreFriendsMessageCollection)
      .document(chatRoomID)
      .collection(chatRoomID)
      .orderBy(firestoreChatTimestampField,descending: true)
      .limit(1)
      .snapshots()
    );

    StreamSubscription subscription = chatRoomListServer[otherUser].listen((snapshot){
      sl.get<CurrentUser>().chatList.add(ChatListModel(
        chatRoomID: chatRoomID,
        profileImage: otherUser.fakeProfileModel.animalImage,
        nickName: otherUser.fakeProfileModel.nickName,
        lastTimestamp: snapshot.documents[0][firestoreChatTimestampField],
        user: otherUser
      ));
    });

    chatRoomListSubscriptions[otherUser.uid] = subscription;
  }

  /// [친구차단 → 채팅방 해제]
  Future<void> disconnectChatRoom({@required String otherUserUID}) async{
    await chatRoomListSubscriptions[otherUserUID].cancel();
    chatRoomListServer.remove(otherUserUID);
  } 


  Future<String> _getChatRoomID(String otherUser) async {
    String currentUser = sl.get<CurrentUser>().uid;
    String user0,user1;

    if(currentUser.compareTo(otherUser)<0) {
      user0 = currentUser;
      user1 = otherUser;
    } else {
      user0 = otherUser;
      user1 = currentUser;
    }

    QuerySnapshot querySnapshot = await sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreFriendsMessageCollection)
      .where(firestoreChatUsersField[0], isEqualTo: user0)
      .where(firestoreChatUsersField[1], isEqualTo: user1)
      .getDocuments();
    
    return querySnapshot.documents[0].documentID;
  }
}