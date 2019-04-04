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
import 'package:privacy_of_animal/logics/other_profile/other_profile.dart';
import 'package:privacy_of_animal/logics/same_match/same_match.dart';
import 'package:privacy_of_animal/models/chat_list_model.dart';
import 'package:privacy_of_animal/models/user_model.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServerAPI {

  static bool _isFirstFriendsFetch = true;
  static bool _isFirstRequestFetch = true;
  static Map<String,bool> _isFirstChatHistoryFetch = Map<String,bool>();

  Map<String, Observable<QuerySnapshot>> _chatRoomListServer;
  Map<String, StreamSubscription<QuerySnapshot>> _chatRoomListSubscriptions;

  Observable<QuerySnapshot> _friendsServer;
  StreamSubscription _friendsSubscription;

  Observable<QuerySnapshot> _requestFromServer;
  StreamSubscription _requestFromSubscription;

  StreamSubscription _requestToSubscription;

  final Firestore _firestore = sl.get<FirebaseAPI>().getFirestore();
  final FriendsBloc _friendsBloc = sl.get<FriendsBloc>();
  final FriendsChatBloc _friendsChatBloc = sl.get<FriendsChatBloc>();
  final ChatListBloc _chatListBloc = sl.get<ChatListBloc>();
  final SameMatchBloc _sameMatchBloc = sl.get<SameMatchBloc>();
  final OtherProfileBloc _otherProfileBloc = sl.get<OtherProfileBloc>();

  ServerAPI() {
    _chatRoomListServer = Map<String, Observable<QuerySnapshot>>();
    _chatRoomListSubscriptions = Map<String, StreamSubscription<QuerySnapshot>>();

    _friendsServer = Observable.empty();
    _friendsSubscription = _friendsServer.listen((_){});

    _requestFromServer = Observable.empty();
    _requestFromSubscription = _requestFromServer.listen((_){});

    _requestToSubscription = Observable.empty().listen((_){});
  }

  /// [매칭화면 → 이미 친구신청 했는지 확인 스트림 연결]
  void connectRequestToStream({@required String otherUserUID}) {
    debugPrint('Call connectRequestToStream($otherUserUID)');

    Stream<QuerySnapshot> requestStreamTo = 
      _firestore
      .collection(firestoreUsersCollection)
      .document(otherUserUID)
      .collection(firestoreFriendsSubCollection)
      .where(firestoreFriendsUID, isEqualTo: sl.get<CurrentUser>().uid)
      .where(firestoreFriendsField, isEqualTo: false).snapshots();
    _requestToSubscription = requestStreamTo.listen((requestSnapshot){
      if(requestSnapshot.documents
        .where((snapshot) => snapshot.documentID==sl.get<CurrentUser>().uid).isEmpty) {
        sl.get<CurrentUser>().isRequestTo = false;
        _sameMatchBloc.emitEvent(SameMatchEventRefreshRequestTo());
        _otherProfileBloc.emitEvent(OtherProfileEventRefreshRequestTo());
      }
    });
  }
  /// [매칭화면 → 이미 친구신청 했는지 확인 스트림 취소]
  Future<void> disconnectRequestToStream() async{
    debugPrint('Call disconnectRequestToStream()');

    await _requestToSubscription.cancel();
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
      await _connectChatRoom(otherUser: UserModel.fromSnapshot(snapshot: friendsInfoSnapshot));
    }
  }

  /// [로그아웃 → 모든 채팅방 해제]
  Future<void> disconnectAllChatRoom() async {
    debugPrint('Call disconnectAllChatRoom()');

    sl.get<CurrentUser>().friendsList.map((friends) async{
      await disconnectChatRoom(otherUserUID: friends.uid);
    });
  }


  /// [로그인 → 친구목록 연결]
  Future<void> connectFriendsList() async {
    debugPrint('Call connectFriendsList()');

    _friendsServer = Observable(
      _firestore
      .collection(firestoreUsersCollection)
      .document(sl.get<CurrentUser>().uid)
      .collection(firestoreFriendsSubCollection)
      .where(firestoreFriendsField, isEqualTo: true)
      .snapshots()
    );
    _friendsSubscription = _friendsServer.listen((snapshot) async{
      if(snapshot.documentChanges.isNotEmpty) {
        
        int beforeFriendsNum = sl.get<CurrentUser>().friendsList.length;

        if(snapshot.documentChanges.where((change)=>
          change.document.documentID==sl.get<CurrentUser>().currentProfileUID).isNotEmpty) {
            _sameMatchBloc.emitEvent(SameMatchEventRefreshLoading());
            _otherProfileBloc.emitEvent(OtherProfileEventRefreshLoading());
          }
        
        // 친구 감소
        if(beforeFriendsNum >= snapshot.documents.length && !_isFirstFriendsFetch) {
          debugPrint('Friends are decreased!!');

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
          _friendsBloc.emitEvent(
            FriendsEventFriendsDecreased(friends: snapshot.documentChanges)
          );
        } 
        // 친구 증가
        else if(!_isFirstFriendsFetch){
          debugPrint('Friends are increased!!');

          for(DocumentChange increasedChange in snapshot.documentChanges) {
            DocumentSnapshot userSnapshot = await _getUserInfo(increasedChange.document.data[firestoreFriendsUID]);
            UserModel user = UserModel.fromSnapshot(snapshot: userSnapshot);
            await _connectChatRoom(otherUser: user);
          }
          _friendsBloc.emitEvent(FriendsEventFriendsIncreased(friends: snapshot.documentChanges));
        } 
        // 처음
        else {
          debugPrint('Initial Friends, Not Empty!!');

          _isFirstFriendsFetch = false;
          _friendsBloc.emitEvent(FriendsEventFirstFriendsFetch(friends: snapshot.documents));
        }
      } else {
        debugPrint('Initial Friends, Empty!!');
        
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
  Future<void> connectRequestFromList() async {
    debugPrint('Call connectRequestFromList()');

    _requestFromServer = Observable(
      _firestore
      .collection(firestoreUsersCollection)
      .document(sl.get<CurrentUser>().uid)
      .collection(firestoreFriendsSubCollection)
      .where(firestoreFriendsField, isEqualTo: false)
      .snapshots()
    );
    _requestFromSubscription = _requestFromServer.listen((snapshot) async{
      if(snapshot.documentChanges.isNotEmpty) {

        // 친구신청 증가
        if(sl.get<CurrentUser>().requestFromList.length < snapshot.documents.length
          && !_isFirstRequestFetch) {
            debugPrint('Requests are increased!!');

            _friendsBloc.emitEvent(
              FriendsEventRequestIncreased(request: snapshot.documentChanges)
            );
          } 
        // 친구신청 감소
        else if(!_isFirstRequestFetch){
          debugPrint('Requests are Decreased!!');

          _friendsBloc.emitEvent(
            FriendsEventRequestDecreased(request: snapshot.documentChanges)
          );
        }
        // 처음
        else {
          debugPrint('Initial Requests, Not Empty!!');

          _isFirstRequestFetch = false;
          _friendsBloc.emitEvent(
            FriendsEventFirstRequestFetch(request: snapshot.documents)
          );
        }
      } 
      // 처음
      else {
        debugPrint('Initial Requests, Empty!!');

        _isFirstRequestFetch = false;
      }
    });
  }

  /// [로그아웃 → 친구신청목록 해제]
  Future<void> disconnectRequestFromList() async {
    debugPrint('Call disconnectRequestFromList()');

    await _requestFromSubscription.cancel();
  }


  /// [친구수락 → 채팅방 연결]
  Future<void> _connectChatRoom({@required UserModel otherUser}) async{
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
      _friendsChatBloc.emitEvent(FriendsChatEvnetFirstChatFetch(
        otherUserUID: otherUserUID,
        chat: snapshot.documents
      ));
    } else if(from==otherUserUID) {
      _friendsChatBloc.emitEvent(FriendsChatEventMessageRecieved(
        snapshot: snapshot,
        otherUserUID: otherUserUID
      ));
    }
  }

  bool _isFriends(UserModel otherUser) {
    debugPrint('Call _isFriends($otherUser)');

    return sl.get<CurrentUser>().friendsList.contains(otherUser);
  }

  void _updateChatListHistory(UserModel otherUser, String chatRoomID, QuerySnapshot snapshot) {
    debugPrint('Call _updateChatListHistory($otherUser,$chatRoomID,$snapshot)');

    _chatListBloc.emitEvent(ChatListEventNew(
      newMessages: snapshot.documentChanges,
      otherUser: otherUser,
      chatRoomID: chatRoomID
    ));
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
      .where('$firestoreChatUsersField.${sl.get<CurrentUser>().uid}', isEqualTo: true)
      .where('$firestoreChatUsersField.$otherUserUID', isEqualTo: true)
      .limit(1)
      .getDocuments();

    assert(friendsChatSnapshot.documents.isNotEmpty, "에러! 친구끼리의 채팅이 없음");
    
    return friendsChatSnapshot.documents[0].documentID;
  }
}
