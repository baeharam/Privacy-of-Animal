
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:privacy_of_animal/logics/chat_list/chat_list.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/logics/friends/friends.dart';
import 'package:privacy_of_animal/logics/other_profile/other_profile.dart';
import 'package:privacy_of_animal/logics/same_match/same_match.dart';
import 'package:privacy_of_animal/logics/server/server_chat_api.dart';
import 'package:privacy_of_animal/models/user_model.dart';
import 'package:privacy_of_animal/resources/resources.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:rxdart/rxdart.dart';

class ServerFriendsAPI {
  static bool _isFirstFriendsFetch = true;

  Observable<QuerySnapshot> _friendsServer;
  StreamSubscription _friendsSubscription;

  final ServerChatAPI _serverChatListAPI = ServerChatAPI();

  ServerFriendsAPI() {
    _friendsServer = Observable.empty();
    _friendsSubscription = _friendsServer.listen((_){});
  }

  

  /// [로그인 → 친구목록 연결]
  Future<void> connectFriendsList() async {
    debugPrint('Call connectFriendsList()');

    _friendsServer = Observable(
      sl.get<FirebaseAPI>().getFirestore()
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
            sl.get<SameMatchBloc>().emitEvent(SameMatchEventRefreshLoading());
            sl.get<OtherProfileBloc>().emitEvent(OtherProfileEventRefreshLoading());
          }
        
        // 친구 감소
        if(beforeFriendsNum >= snapshot.documents.length && !_isFirstFriendsFetch) {
          debugPrint('Friends are decreased!!');

          for(DocumentChange decreasedChange in snapshot.documentChanges) {

            String blockedUserUID = decreasedChange.document.documentID;
            await _serverChatListAPI.disconnectChatRoom(otherUserUID: blockedUserUID);

            sl.get<ChatListBloc>().emitEvent(ChatListEventRefresh());
            UserModel otherUser = UserModel.fromSnapshot(snapshot: await _getUserInfo(blockedUserUID));
            if(_isFriends(otherUser)) {
              sl.get<FriendsBloc>().emitEvent(FriendsEventBlockFromServer(userToBlock: otherUser));
            }
          }
          sl.get<FriendsBloc>().emitEvent(
            FriendsEventFriendsDecreased(friends: snapshot.documentChanges)
          );
        } 
        // 친구 증가
        else if(!_isFirstFriendsFetch){
          debugPrint('Friends are increased!!');

          for(DocumentChange increasedChange in snapshot.documentChanges) {
            DocumentSnapshot userSnapshot = await _getUserInfo(increasedChange.document.data[firestoreFriendsUID]);
            UserModel user = UserModel.fromSnapshot(snapshot: userSnapshot);
            await _serverChatListAPI.connectChatRoom(otherUser: user);
          }
          sl.get<FriendsBloc>().emitEvent(FriendsEventFriendsIncreased(friends: snapshot.documentChanges));
        } 
        // 처음
        else {
          debugPrint('Initial Friends, Not Empty!!');

          _isFirstFriendsFetch = false;
          sl.get<FriendsBloc>().emitEvent(FriendsEventFirstFriendsFetch(friends: snapshot.documents));
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

  /// [친구 맞나 확인]
  bool _isFriends(UserModel otherUser) {
    debugPrint('Call _isFriends($otherUser)');

    return sl.get<CurrentUser>().friendsList.contains(otherUser);
  }

  /// [사용자 정보 가져오기]
  Future<DocumentSnapshot> _getUserInfo(String otherUserUID) async {
    debugPrint('Call _getUserInfo($otherUserUID)');

    return 
      await sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreUsersCollection)
      .document(otherUserUID)
      .get();
  }
}