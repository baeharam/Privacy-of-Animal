
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:privacy_of_animal/logics/chat_list/chat_list.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/logics/friends_chat/friends_chat.dart';
import 'package:privacy_of_animal/models/user_model.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:rxdart/rxdart.dart';

class ServerChatAPI {

  static Map<String,bool> _isFirstChatHistoryFetch = Map<String,bool>();

  Map<String, Observable<QuerySnapshot>> _chatRoomListServer;
  Map<String, StreamSubscription<QuerySnapshot>> _chatRoomListSubscriptions;

  final Firestore _firestore = sl.get<FirebaseAPI>().getFirestore();

  ServerChatAPI() {
    _chatRoomListServer = Map<String, Observable<QuerySnapshot>>();
    _chatRoomListSubscriptions = Map<String, StreamSubscription<QuerySnapshot>>();
  }

  /// [로그인 → 모든 채팅방 연결]
  Future<void> connectAllChatRoom() async {
    debugPrint('Call connectAllChatRoom()');

    QuerySnapshot friendsListSnapshot = 
      await _firestore
      .collection(firestoreUsersCollection)
      .document(sl.get<CurrentUser>().uid)
      .collection(firestoreFriendsSubCollection)
      .where(firestoreFriendsField,isEqualTo: true)
      .getDocuments();

    for(DocumentSnapshot friends in friendsListSnapshot.documents) {
      DocumentSnapshot friendsInfoSnapshot = 
        await _firestore
        .collection(firestoreUsersCollection)
        .document(friends.documentID)
        .get();
      await connectChatRoom(otherUser: UserModel.fromSnapshot(snapshot: friendsInfoSnapshot));
    }
  }

  /// [로그아웃 → 모든 채팅방 해제]
  Future<void> disconnectAllChatRoom() async {
    debugPrint('Call disconnectAllChatRoom()');

    sl.get<CurrentUser>().friendsList.map((friends) async{
      await disconnectChatRoom(otherUserUID: friends.uid);
    });
  }

  /// [친구수락 → 채팅방 연결]
  Future<void> connectChatRoom({@required UserModel otherUser}) async{
    debugPrint('Call _connectChatRoom($otherUser)');

    String chatRoomID = await _getChatRoomID(otherUser.uid);
    Timestamp outTimestamp = await _getChatRoomOutTimestamp(chatRoomID);
    _isFirstChatHistoryFetch[otherUser.uid] ??= true;

    _chatRoomListServer[otherUser.uid] = Observable(
      _firestore
      .collection(firestoreFriendsMessageCollection)
      .document(chatRoomID)
      .collection(chatRoomID)
      .orderBy(firestoreChatTimestampField,descending: true)
      .where(firestoreChatTimestampField,isGreaterThan: outTimestamp)
      .snapshots()
    );

    _chatRoomListSubscriptions[otherUser.uid] = _chatRoomListServer[otherUser.uid].listen((snapshot){
      if(snapshot.documentChanges.isNotEmpty) {
        _updateChatHistory(otherUser.uid, snapshot);
        _updateChatListHistory(otherUser, chatRoomID, snapshot);
      }
    });
  }

  /// [친구차단 → 채팅방 해제]
  Future<void> disconnectChatRoom({@required String otherUserUID}) async{
    debugPrint('Call disconnectChatRoom($otherUserUID)');

    await _chatRoomListSubscriptions[otherUserUID].cancel();
    _chatRoomListServer.remove(otherUserUID);
  }

  void _updateChatHistory(String otherUserUID, QuerySnapshot snapshot) {
    debugPrint('Call _updateChatHistory($otherUserUID,$snapshot)');

    String from = snapshot.documentChanges[0].document.data[firestoreChatFromField];

    if(_isFirstChatHistoryFetch[otherUserUID]) {
      _isFirstChatHistoryFetch[otherUserUID] = false;
      sl.get<FriendsChatBloc>().emitEvent(FriendsChatEvnetFirstChatFetch(
        otherUserUID: otherUserUID,
        chat: snapshot.documents
      ));
    } else if(from==otherUserUID) {
      sl.get<FriendsChatBloc>().emitEvent(FriendsChatEventMessageRecieved(
        snapshot: snapshot,
        otherUserUID: otherUserUID
      ));
    }
  }

  void _updateChatListHistory(UserModel otherUser, String chatRoomID, QuerySnapshot snapshot) {
    debugPrint('Call _updateChatListHistory($otherUser,$chatRoomID,$snapshot)');

    sl.get<ChatListBloc>().emitEvent(ChatListEventNew(
      newMessages: snapshot.documentChanges,
      otherUser: otherUser,
      chatRoomID: chatRoomID
    ));
  }

  Future<String> _getChatRoomID(String otherUserUID) async {
    debugPrint('Call _getChatRoomID($otherUserUID)');

    QuerySnapshot friendsChatSnapshot = 
      await _firestore
      .collection(firestoreFriendsMessageCollection)
      .where('$firestoreChatUsersField.${sl.get<CurrentUser>().uid}', isEqualTo: true)
      .where('$firestoreChatUsersField.$otherUserUID', isEqualTo: true)
      .limit(1)
      .getDocuments();

    assert(friendsChatSnapshot.documents.isNotEmpty, "에러! 친구끼리의 채팅이 없음");
    
    return friendsChatSnapshot.documents[0].documentID;
  }

  Future<Timestamp> _getChatRoomOutTimestamp(String chatRoomID) async {
    debugPrint('Call _getChatRoomOutTimestamp($chatRoomID)');

    DocumentSnapshot doc = 
      await _firestore
      .collection(firestoreFriendsMessageCollection)
      .document(chatRoomID)
      .get();
    return doc.data[firestoreChatOutField][sl.get<CurrentUser>().uid];
  }
}