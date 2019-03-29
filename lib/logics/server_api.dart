import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:privacy_of_animal/logics/chat_list/chat_list.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/database_helper.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/logics/friends/friends.dart';
import 'package:privacy_of_animal/logics/friends_chat/friends_chat.dart';
import 'package:privacy_of_animal/logics/same_match/same_match.dart';
import 'package:privacy_of_animal/models/chat_list_model.dart';
import 'package:privacy_of_animal/models/same_match_model.dart';
import 'package:privacy_of_animal/models/user_model.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServerAPI {

  static bool _isFirstFriendsFetch = true;
  static bool _isFirstFriendsRequestFetch = true;
  static Map<String,bool> _isFirstChatHistoryFetch = Map<String,bool>();

  Map<String, Observable<QuerySnapshot>> _chatRoomListServer;
  Map<String, StreamSubscription<QuerySnapshot>> _chatRoomListSubscriptions;

  Observable<QuerySnapshot> _friendsServer;
  StreamSubscription _friendsSubscription;

  Observable<QuerySnapshot> _friendsRequestServer;
  StreamSubscription _friendsRequestSubscription;

  StreamSubscription _matchSubscription;

  final CurrentUser _currentUser = sl.get<CurrentUser>();
  final Firestore _firestore = sl.get<FirebaseAPI>().getFirestore();
  final SameMatchBloc _sameMatchBloc = sl.get<SameMatchBloc>();
  final FriendsBloc _friendsBloc = sl.get<FriendsBloc>();
  final FriendsChatBloc _friendsChatBloc = sl.get<FriendsChatBloc>();
  final ChatListBloc _chatListBloc = sl.get<ChatListBloc>();

  ServerAPI() {
    _chatRoomListServer = Map<String, Observable<QuerySnapshot>>();
    _chatRoomListSubscriptions = Map<String, StreamSubscription<QuerySnapshot>>();

    _friendsServer = Observable.empty();
    _friendsSubscription = _friendsServer.listen((_){});

    _friendsRequestServer = Observable.empty();
    _friendsRequestSubscription = _friendsRequestServer.listen((_){});

    _matchSubscription = Stream.empty().listen((_){});
  }

  /// [특정사람 매칭 → 친구이거나 친구 신청 받았는지 확인]
  void connectMatchStream({@required SameMatchModel sameMatchModel}) {
    debugPrint('Call connectMatchStream($sameMatchModel)');

    Stream<QuerySnapshot> requestStreamFrom = 
      _firestore
      .collection(firestoreUsersCollection)
      .document(_currentUser.uid)
      .collection(firestoreFriendsSubCollection)
      .where(firestoreFriendsUID, isEqualTo: sameMatchModel.userInfo.uid)
      .where(firestoreFriendsField, isEqualTo: false).snapshots();

    Stream<QuerySnapshot> friendsStream =
      _firestore
      .collection(firestoreUsersCollection)
      .document(sameMatchModel.userInfo.uid)
      .collection(firestoreFriendsSubCollection)
      .where(firestoreFriendsUID, isEqualTo: _currentUser.uid)
      .where(firestoreFriendsField, isEqualTo: true).snapshots();

    Observable<bool> combinedStream = 
    Observable.combineLatest2(friendsStream, requestStreamFrom,(s1,s2)
      => (s1.documents.isNotEmpty || s2.documents.isNotEmpty)
    );

    _matchSubscription = combinedStream.listen((isAlreadyFriends){
      if(isAlreadyFriends) {
        _sameMatchBloc.emitEvent(SameMatchEventFriendsStateUpdate());
      }
    });
  }

  /// [특정 사람 매칭 스트림 취소]
  Future<void> disconnectMatchStream() async{
    debugPrint('Call disconnectMatchStream()');

    await _matchSubscription.cancel();
  }


  /// [로그인 → 모든 채팅방 연결]
  Future<void> connectAllChatRoom() async {
    debugPrint('Call connectAllChatRoom()');

    QuerySnapshot friendsListSnapshot = 
      await _firestore
      .collection(firestoreUsersCollection)
      .document(_currentUser.uid)
      .collection(firestoreFriendsSubCollection)
      .where(firestoreFriendsField,isEqualTo: true)
      .getDocuments();

    for(DocumentSnapshot friends in friendsListSnapshot.documents) {
      DocumentSnapshot friendsInfoSnapshot = 
        await _firestore
        .collection(firestoreUsersCollection)
        .document(friends.documentID)
        .get();
      await _connectChatRoom(otherUser: UserModel.fromSnapshot(snapshot: friendsInfoSnapshot));
    }
  }

  /// [로그아웃 → 모든 채팅방 해제]
  Future<void> disconnectAllChatRoom() async {
    debugPrint('Call disconnectAllChatRoom()');

    _currentUser.friendsList.map((friends) async{
      await disconnectChatRoom(otherUserUID: friends.uid);
    });
  }


  /// [로그인 → 친구목록 연결]
  Future<void> connectFriendsList() async {
    debugPrint('Call connectFriendsList()');

    _friendsServer = Observable(
      _firestore
      .collection(firestoreUsersCollection)
      .document(_currentUser.uid)
      .collection(firestoreFriendsSubCollection)
      .where(firestoreFriendsField, isEqualTo: true)
      .snapshots()
    );
    _friendsSubscription = _friendsServer.listen((snapshot) async{
      if(snapshot.documentChanges.isNotEmpty) {
        
        int beforeFriendsNum = _currentUser.friendsList.length;

        // 친구 감소
        if(beforeFriendsNum > snapshot.documents.length) {
          for(DocumentChange decreasedChange in snapshot.documentChanges) {

            String blockedUserUID = decreasedChange.document.documentID;

            await disconnectChatRoom(otherUserUID: blockedUserUID);
            await _deleteChatRoomNotification(blockedUserUID);

            _chatListBloc.emitEvent(ChatListEventRefresh());
            UserModel otherUser = UserModel.fromSnapshot(snapshot: await _getUserInfo(blockedUserUID));
            if(_isFriends(otherUser)) {
              _friendsBloc.emitEvent(FriendsEventBlockFromServer(userToBlock: otherUser));
            }
          }
        } 
        // 친구 증가
        else if(!_isFirstFriendsFetch){
          String newFriendsNickName = '';
          for(DocumentChange increasedChange in snapshot.documentChanges) {
            DocumentSnapshot userSnapshot = await _getUserInfo(increasedChange.document.data[firestoreFriendsUID]);
            UserModel user = UserModel.fromSnapshot(snapshot: userSnapshot);
            if(increasedChange.document.data[firestoreFriendsAccepted]==true) {
              newFriendsNickName = user.fakeProfileModel.nickName;
            }
            /// TODO 친구 알림
            await _connectChatRoom(otherUser: user);
          }
          _friendsBloc.emitEvent(FriendsEventNewFriends(newFriendsNum: snapshot.documentChanges.length));
        } 
        // 처음
        else {
          _isFirstFriendsFetch = false;
        }

        _friendsBloc.emitEvent(FriendsEventRefreshFriends(friends: snapshot.documents));
      } else {
        _isFirstFriendsFetch = false;
      }
    });
  }

  /// [로그아웃 → 친구목록 해제]
  Future<void> disconnectFriendsList() async {
    debugPrint('Call disconnectFriendsList()');

    await _friendsSubscription.cancel();
  }

  /// [로그인 → 친구신청목록 연결]
  Future<void> connectFriendsRequestList() async {
    debugPrint('Call connectFriendsRequestList()');

    _friendsRequestServer = Observable(
      _firestore
      .collection(firestoreUsersCollection)
      .document(_currentUser.uid)
      .collection(firestoreFriendsSubCollection)
      .where(firestoreFriendsField, isEqualTo: false)
      .snapshots()
    );
    _friendsRequestSubscription = _friendsRequestServer.listen((snapshot) async{
      if(snapshot.documentChanges.isNotEmpty) {
        if(_currentUser.friendsRequestList.length < snapshot.documents.length
          && !_isFirstFriendsRequestFetch) {
            DocumentSnapshot userSnapshot = 
              await _getUserInfo(snapshot.documentChanges[0].document.data[firestoreFriendsUID]);
            /// TODO 친구 신청 알림
          } else {
            _isFirstFriendsRequestFetch = false;
          }
        _friendsBloc.emitEvent(FriendsEventRefreshRequest(friendsRequest: snapshot.documents));
      } else {
        _isFirstFriendsRequestFetch = false;
      }
    });
  }

  /// [로그아웃 → 친구신청목록 해제]
  Future<void> disconnectFriendsRequestList() async {
    debugPrint('Call disconnectFriendsRequestList()');

    await _friendsRequestSubscription.cancel();
  }


  /// [친구수락 → 채팅방 연결]
  Future<void> _connectChatRoom({@required UserModel otherUser}) async{
    debugPrint('Call _connectChatRoom($otherUser');

    String chatRoomID = await _getChatRoomID(otherUser.uid);
    Timestamp outTimestamp = await _getChatRoomOutTimestamp(chatRoomID);
    _isFirstChatHistoryFetch[chatRoomID] ??= true;

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
      if(snapshot.documents.isNotEmpty) {
        _updateChatListHistory(otherUser, chatRoomID, snapshot);
      }
      if(snapshot.documentChanges.isNotEmpty) {
        _updateChatHistory(otherUser, chatRoomID, snapshot);
      }
    });
  }

  /// [친구차단 → 채팅방 해제]
  Future<void> disconnectChatRoom({@required String otherUserUID}) async{
    debugPrint('Call disconnectChatRoom($otherUserUID');

    await _chatRoomListSubscriptions[otherUserUID].cancel();
    _chatRoomListServer.remove(otherUserUID);
  }

  void _updateChatHistory(UserModel otherUser, String chatRoomID, QuerySnapshot snapshot) {
    debugPrint('Call _updateChatHistory($otherUser,$chatRoomID,$snapshot');

    String from = snapshot.documentChanges[0].document.data[firestoreChatFromField];
    if(_isFirstChatHistoryFetch[chatRoomID] || from==otherUser.uid) {
      _friendsChatBloc.emitEvent(FriendsChatEventMessageRecieved(
        snapshot: snapshot,
        otherUserUID: otherUser.uid
      ));
      if(!_isFirstChatHistoryFetch[chatRoomID] 
        && _currentUser.chatRoomNotification[chatRoomID]
        && chatRoomID!=_currentUser.currentChatRoomID){
          /// TODO 새로운 채팅 알림
      }
      if(_isFirstChatHistoryFetch[chatRoomID]) {
        _isFirstChatHistoryFetch[chatRoomID] = false;
      }
    }
  }

  bool _isFriends(UserModel otherUser) {
    debugPrint('Call _isFriends($otherUser');
    return _currentUser.friendsList.contains(otherUser);
  }

  void _updateChatListHistory(UserModel otherUser, String chatRoomID, QuerySnapshot snapshot) {
    debugPrint('Call _updateChatListHistory($otherUser,$chatRoomID,$snapshot)');
    _chatListBloc.emitEvent(ChatListEventNew(newMessage: 
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
    debugPrint('Call _getChatRoomOutTimestamp($chatRoomID)');
    DocumentSnapshot doc = 
      await _firestore
      .collection(firestoreFriendsMessageCollection)
      .document(chatRoomID)
      .get();
    return doc.data[firestoreChatOutField][_currentUser.uid];
  }

  Future<void> _deleteChatRoomNotification(String otherUserUID) async {
    debugPrint('Call _deleteChatRoomNotification($otherUserUID)');
    SharedPreferences prefs = await sl.get<DatabaseHelper>().sharedPreferences;
    await prefs.remove(otherUserUID+chatNotification);
  }

  Future<DocumentSnapshot> _getUserInfo(String otherUserUID) async {
    debugPrint('Call _getUserInfo($otherUserUID)');
    return 
      await _firestore
      .collection(firestoreUsersCollection)
      .document(otherUserUID)
      .get();
  }


  Future<String> _getChatRoomID(String otherUserUID) async {
    debugPrint('Call _getChatRoomID($otherUserUID)');

    QuerySnapshot friendsChatSnapshot = 
      await _firestore
      .collection(firestoreFriendsMessageCollection)
      .where('$firestoreChatUsersField.${_currentUser.uid}', isEqualTo: true)
      .where('$firestoreChatUsersField.$otherUserUID', isEqualTo: true)
      .limit(1)
      .getDocuments();

    assert(friendsChatSnapshot.documents.isNotEmpty, "에러! 친구끼리의 채팅이 없음");
    
    return friendsChatSnapshot.documents[0].documentID;
  }
}