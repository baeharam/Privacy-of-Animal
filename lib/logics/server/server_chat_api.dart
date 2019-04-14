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

  ServerChatAPI() {
    _chatRoomListServer = Map<String, Observable<QuerySnapshot>>();
    _chatRoomListSubscriptions = Map<String, StreamSubscription<QuerySnapshot>>();
  }

  /// [플래그 비활성화]
  void deactivateFlags() => _isFirstChatHistoryFetch.clear();


  /// [로그인 → 모든 채팅방 연결]
  Future<void> connectAllChatRoom() async {
    debugPrint('[채팅] 모든 채팅방 연결');

    QuerySnapshot friendsListSnapshot = 
      await sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreUsersCollection)
      .document(sl.get<CurrentUser>().uid)
      .collection(firestoreFriendsSubCollection)
      .where(firestoreFriendsField,isEqualTo: true)
      .getDocuments();

    for(DocumentSnapshot friends in friendsListSnapshot.documents) {
      DocumentSnapshot friendsInfoSnapshot = 
        await sl.get<FirebaseAPI>().getUserSnapshot(friends.documentID);
      await connectChatRoom(otherUser: UserModel.fromSnapshot(snapshot: friendsInfoSnapshot));
    }
  }

  /// [로그아웃 → 모든 채팅방 해제]
  Future<void> disconnectAllChatRoom() async {
    debugPrint('[채팅] 모든 채팅방 해제');

    sl.get<CurrentUser>().friendsList.map((friends) async{
      await disconnectChatRoom(otherUserUID: friends.uid);
    });
  }

  /// [친구수락 → 채팅방 연결]
  Future<void> connectChatRoom({@required UserModel otherUser}) async{
    debugPrint('[채팅] ${otherUser.uid}의 채팅방 연결');

    String chatRoomID = await _getChatRoomID(otherUser.uid);
    Timestamp outTimestamp = await _getChatRoomOutTimestamp(otherUser.uid);
    _isFirstChatHistoryFetch[otherUser.uid] ??= true;

    _chatRoomListServer[otherUser.uid] = Observable(
      sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreFriendsMessageCollection)
      .document(chatRoomID)
      .collection(chatRoomID)
      .orderBy(firestoreChatTimestampField,descending: true)
      .where(firestoreChatTimestampField,isGreaterThan: outTimestamp)
      .snapshots()
    );

    _chatRoomListSubscriptions[otherUser.uid] = _chatRoomListServer[otherUser.uid].listen((snapshot){
      if(snapshot.documentChanges.isNotEmpty) {
        _updateChatHistory(otherUser, snapshot);
        _updateChatListHistory(otherUser, chatRoomID, snapshot);
      } else {
        _isFirstChatHistoryFetch[otherUser.uid] = false;
      }
    });
  }

  /// [친구차단 → 채팅방 해제]
  Future<void> disconnectChatRoom({@required String otherUserUID}) async{
    debugPrint('[채팅] $otherUserUID의 채팅방 해제');

    await _chatRoomListSubscriptions[otherUserUID].cancel();
    _chatRoomListServer.remove(otherUserUID);
  }

  /// [채팅내용 업데이트]
  void _updateChatHistory(UserModel otherUser, QuerySnapshot snapshot) {

    String from = snapshot.documentChanges[0].document.data[firestoreChatFromField];

    if(_isFirstChatHistoryFetch[otherUser.uid]) {
      _isFirstChatHistoryFetch[otherUser.uid] = false;
      sl.get<FriendsChatBloc>().emitEvent(FriendsChatEvnetFirstChatFetch(
        otherUserUID: otherUser.uid,
        chat: snapshot.documents
      ));
    } else if(from==otherUser.uid) {
      sl.get<FriendsChatBloc>().emitEvent(FriendsChatEventMessageRecieved(
        snapshot: snapshot,
        otherUserUID: otherUser.uid,
        nickName: otherUser.fakeProfileModel.nickName
      ));
    }
  }

  /// [채팅 리스트 업데이트]
  void _updateChatListHistory(UserModel otherUser, String chatRoomID, QuerySnapshot snapshot) {
    debugPrint('[채팅] ${otherUser.uid}와의 채팅 리스트 업데이트');

    sl.get<ChatListBloc>().emitEvent(ChatListEventNew(
      newMessages: snapshot.documentChanges,
      otherUser: otherUser,
      chatRoomID: chatRoomID
    ));
  }

  /// [채팅방 ID 가져오기]
  Future<String> _getChatRoomID(String otherUserUID) async {
    debugPrint('[채팅] $otherUserUID와의 채팅방 ID가져오기');

    QuerySnapshot friendsChatSnapshot = 
      await sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreFriendsMessageCollection)
      .where('$firestoreChatUsersField.${sl.get<CurrentUser>().uid}', isEqualTo: true)
      .where('$firestoreChatUsersField.$otherUserUID', isEqualTo: true)
      .limit(1)
      .getDocuments();

    assert(friendsChatSnapshot.documents.isNotEmpty, "[채팅] 에러! 친구끼리의 채팅이 없음");
    
    return friendsChatSnapshot.documents[0].documentID;
  }

  /// [채팅방 가장 마지막에 나간 시간 가져오기]
  Future<Timestamp> _getChatRoomOutTimestamp(String otherUserUID) async {
    debugPrint('[채팅] $otherUserUID와의 채팅방에서 나간 시간 가져오기');

    QuerySnapshot doc = 
      await sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreFriendsMessageCollection)
      .where('$firestoreChatUsersField.${sl.get<CurrentUser>().uid}',isEqualTo: true)
      .where('$firestoreChatUsersField.$otherUserUID',isEqualTo: true)
      .limit(1)
      .getDocuments();
    return doc.documents[0].data[firestoreChatOutField][sl.get<CurrentUser>().uid];
  }
}