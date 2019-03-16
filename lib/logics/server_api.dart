import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/logics/friends/friends.dart';
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

  Observable<QuerySnapshot> friendsAcceptServer;
  StreamSubscription friendsAcceptSubscription;

  /// [로그인 → 친구수락 여부 연결]
  Future<void> connectFriendsAccept() async {
    friendsAcceptServer =Observable(sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreUsersCollection)
      .document(sl.get<CurrentUser>().uid)
      .collection(firestoreFriendsSubCollection)
      .where(firestoreFriendsField, isEqualTo: true)
      .where(firestoreFriendsAccepted, isEqualTo: true)
      .snapshots());

    friendsAcceptSubscription =friendsAcceptServer.listen((snapshot){
      if(snapshot.documentChanges.isNotEmpty) {
        snapshot.documents.map((userDoc) async{
          String user = userDoc.documentID;
          if(chatRoomListServer[user]==null){
            DocumentSnapshot userInfoSnapshot = await _getUserInfo(user);
            await connectChatRoom(otherUser: UserModel.fromSnapshot(snapshot: userInfoSnapshot));
          }
        });
      }
    });
  }

  /// [로그아웃 → 친구수락 여부 해제]
  Future<void> disconnectFriendsAccept() async {
    await friendsAcceptSubscription.cancel();
  }


  /// [로그인 → 친구목록 연결]
  Future<void> connectFriendsList() async {
    friendsListServer = Observable(sl.get<FirebaseAPI>().getFirestore()
        .collection(firestoreUsersCollection)
        .document(sl.get<CurrentUser>().uid)
        .collection(firestoreFriendsSubCollection)
        .where(firestoreFriendsField, isEqualTo: true)
        .snapshots());
    friendsListSubscription = friendsListServer.listen((snapshot) {
      if(snapshot.documentChanges.isNotEmpty) {
        sl.get<FriendsBloc>().emitEvent(FriendsEventFetchFriendsList(friends: snapshot.documents));
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
        sl.get<FriendsBloc>().emitEvent(FriendsEventFetchFriendsRequestList(friendsRequest: snapshot.documents));
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

    StreamSubscription subscription = chatRoomListServer[otherUser.uid].listen((snapshot){
      if(snapshot.documents.isNotEmpty) {
        sl.get<CurrentUser>().chatList.add(ChatListModel(
          chatRoomID: chatRoomID,
          profileImage: otherUser.fakeProfileModel.animalImage,
          nickName: otherUser.fakeProfileModel.nickName,
          lastTimestamp: snapshot.documents[0].data[firestoreChatTimestampField],
          user: otherUser
        ));
      }
    });

    chatRoomListSubscriptions[otherUser.uid] = subscription;
  }

  /// [친구차단 → 채팅방 해제]
  Future<void> disconnectChatRoom({@required String otherUserUID}) async{
    await chatRoomListSubscriptions[otherUserUID].cancel();
    chatRoomListServer.remove(otherUserUID);
  }

  Future<DocumentSnapshot> _getUserInfo(String user) async {
    return await sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreUsersCollection)
      .document(user).get();
  }


  Future<String> _getChatRoomID(String otherUser) async {
    String currentUser = sl.get<CurrentUser>().uid;

    QuerySnapshot querySnapshot = await sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreFriendsMessageCollection)
      .where('$firestoreChatUsersField.$currentUser', isEqualTo: true)
      .where('$firestoreChatUsersField.$otherUser', isEqualTo: true)
      .getDocuments();

    print(querySnapshot.documents.length);
    
    return querySnapshot.documents[0].documentID;
  }
}