import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:privacy_of_animal/logics/chat_list/chat_list.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/database_helper.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/logics/friends/friends.dart';
import 'package:privacy_of_animal/logics/friends_chat/friends_chat.dart';
import 'package:privacy_of_animal/logics/notification_helper.dart';
import 'package:privacy_of_animal/models/chat_list_model.dart';
import 'package:privacy_of_animal/models/user_model.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServerAPI {

  static bool isFirstFriendsFetch = true;
  static bool isFirstFriendsRequestFetch = true;
  static Map<String,bool> isFirstChatHistoryFetch = Map<String,bool>();

  var chatRoomListServer = Map<String, Observable<QuerySnapshot>>();
  var chatRoomListSubscriptions = Map<String, StreamSubscription<QuerySnapshot>>();

  Observable<QuerySnapshot> friendsListServer;
  StreamSubscription friendsListSubscription;

  Observable<QuerySnapshot> friendsRequestListServer;
  StreamSubscription friendsRequestListSubscription;


  /// [로그인 → 모든 채팅방 연결]
  Future<void> connectAllChatRoom() async {
    String currentUser = sl.get<CurrentUser>().uid;

    QuerySnapshot friendsListSnapshot = await sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreUsersCollection)
      .document(currentUser)
      .collection(firestoreFriendsSubCollection)
      .where(firestoreFriendsField,isEqualTo: true)
      .getDocuments();

    for(DocumentSnapshot friends in friendsListSnapshot.documents) {
      DocumentSnapshot friendsInfo = await sl.get<FirebaseAPI>().getFirestore()
        .collection(firestoreUsersCollection)
        .document(friends.documentID)
        .get();
      await connectChatRoom(otherUser: UserModel.fromSnapshot(snapshot: friendsInfo));
    }
  }

  /// [로그아웃 → 모든 채팅방 해제]
  Future<void> disconnectAllChatRoom() async {
    sl.get<CurrentUser>().friendsList.map((friends) async{
      await disconnectChatRoom(otherUserUID: friends.uid);
    });
  }


  /// [로그인 → 친구목록 연결]
  Future<void> connectFriendsList() async {
    friendsListServer = Observable(sl.get<FirebaseAPI>().getFirestore()
        .collection(firestoreUsersCollection)
        .document(sl.get<CurrentUser>().uid)
        .collection(firestoreFriendsSubCollection)
        .where(firestoreFriendsField, isEqualTo: true)
        .snapshots());
    friendsListSubscription = friendsListServer.listen((snapshot) async{
      if(snapshot.documentChanges.isNotEmpty) {
        int beforeFriendsNum = sl.get<CurrentUser>().friendsList.length;

        // 친구 감소
        if(beforeFriendsNum > snapshot.documents.length) {
          for(DocumentChange update in snapshot.documentChanges) {
            await disconnectChatRoom(otherUserUID: update.document.documentID);
            await deleteChatRoomNotification(update.document.documentID);
            sl.get<ChatListBloc>().emitEvent(ChatListEventFriendsDeleted(
              friends: update.document.data[firestoreFriendsUID])
            );
          }
          sl.get<CurrentUser>().newFriendsNum = 0;
        } 
        // 친구 증가
        else if(!isFirstFriendsFetch){
          String newFriendsNickName = '';
          for(DocumentChange update in snapshot.documentChanges) {
            DocumentSnapshot userSnapshot = await _getUserInfo(update.document.data[firestoreFriendsUID]);
            UserModel user = UserModel.fromSnapshot(snapshot: userSnapshot);
            if(update.document.data[firestoreFriendsAccepted]==true) {
              newFriendsNickName = user.fakeProfileModel.nickName;
            }
            await connectChatRoom(otherUser: user);
          }
          
          sl.get<FriendsBloc>().emitEvent(FriendsEventNewFriends(
            newFriendsNum: snapshot.documentChanges.length));
          if(newFriendsNickName.isNotEmpty && sl.get<CurrentUser>().friendsNotification) {
            sl.get<NotificationHelper>().showFriendsNotification(newFriendsNickName);
          }
        } 
        // 처음
        else {
          isFirstFriendsFetch = false;
        }

        sl.get<FriendsBloc>().emitEvent(FriendsEventFetchFriendsList(friends: snapshot.documents));
      } else {
        isFirstFriendsFetch = false;
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
    friendsRequestListSubscription = friendsRequestListServer.listen((snapshot) async{
      if(snapshot.documentChanges.isNotEmpty) {
        if(sl.get<CurrentUser>().friendsRequestList.length < snapshot.documents.length
          && sl.get<CurrentUser>().friendsNotification && !isFirstFriendsRequestFetch) {
            DocumentSnapshot userSnapshot = 
              await _getUserInfo(snapshot.documentChanges[0].document.data[firestoreFriendsUID]);
            sl.get<NotificationHelper>()
              .showFriendsRequestNotification(userSnapshot.data[firestoreFakeProfileField][firestoreNickNameField]);
          } else {
            isFirstFriendsRequestFetch = false;
          }
        sl.get<FriendsBloc>().emitEvent(FriendsEventFetchFriendsRequestList(friendsRequest: snapshot.documents));
      } else {
        isFirstFriendsRequestFetch = false;
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
    Timestamp outTimestamp = await _getChatRoomOutTimestamp(chatRoomID);
    isFirstChatHistoryFetch[chatRoomID] ??= true;

    chatRoomListServer[otherUser.uid] = Observable(
      sl.get<FirebaseAPI>().getFirestore()
        .collection(firestoreFriendsMessageCollection)
        .document(chatRoomID)
        .collection(chatRoomID)
        .orderBy(firestoreChatTimestampField,descending: true)
        .where(firestoreChatTimestampField,isGreaterThan: outTimestamp)
        .snapshots()
    );

    chatRoomListSubscriptions[otherUser.uid] = chatRoomListServer[otherUser.uid].listen((snapshot){
      if(snapshot.documents.isNotEmpty) {
        _updateChatListHistory(otherUser, chatRoomID, snapshot);
      }
      if(snapshot.documentChanges.isNotEmpty) {
        _updateChatHistory(otherUser.uid, chatRoomID, snapshot);
      }
    });
  }

  /// [친구차단 → 채팅방 해제]
  Future<void> disconnectChatRoom({@required String otherUserUID}) async{
    await chatRoomListSubscriptions[otherUserUID].cancel();
    chatRoomListServer.remove(otherUserUID);
  }

  void _updateChatHistory(String otherUserUID, String chatRoomID, QuerySnapshot snapshot) {
    if(isFirstChatHistoryFetch[chatRoomID] ||
        snapshot.documentChanges[0].document.data[firestoreChatFromField]!=sl.get<CurrentUser>().uid) {
          if(isFirstChatHistoryFetch[chatRoomID]) isFirstChatHistoryFetch[chatRoomID] = false;
          sl.get<FriendsChatBloc>().emitEvent(FriendsChatEventMessageRecieved(
            snapshot: snapshot,
            otherUserUID: otherUserUID
          ));
    }
  }

  void _updateChatListHistory(UserModel otherUser, String chatRoomID, QuerySnapshot snapshot) {
    sl.get<ChatListBloc>().emitEvent(ChatListEventNew(newMessage: 
      ChatListModel(
        chatRoomID: chatRoomID,
        profileImage: otherUser.fakeProfileModel.animalImage,
        nickName: otherUser.fakeProfileModel.nickName,
        lastTimestamp: snapshot.documents[0].data[firestoreChatTimestampField],
        lastMessage: snapshot.documents[0].data[firestoreChatContentField],
        user: otherUser
      )
    ));
  }

  Future<Timestamp> _getChatRoomOutTimestamp(String chatRoomID) async {
    DocumentSnapshot doc = await sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreFriendsMessageCollection)
      .document(chatRoomID).get();
    return doc.data[firestoreChatOutField][sl.get<CurrentUser>().uid];
  }

  Future<void> deleteChatRoomNotification(String user) async {
    SharedPreferences prefs = await sl.get<DatabaseHelper>().sharedPreferences;
    String chatRoomID = await _getChatRoomID(user);
    await prefs.remove(chatRoomID);
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
    
    return querySnapshot.documents[0].documentID;
  }
}