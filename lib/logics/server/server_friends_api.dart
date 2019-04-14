
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
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

  ServerFriendsAPI() {
    _friendsServer = Observable.empty();
    _friendsSubscription = _friendsServer.listen((_){});
  }

  /// [플래그 비활성화]
  void deactivateFlags() => _isFirstFriendsFetch = true;
  

  /// [로그인 → 친구목록 연결]
  Future<void> connectFriendsList() async {
    debugPrint('[친구] 친구목록 스트림 연결');

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
        
        /// [친구 감소]
        if(beforeFriendsNum >= snapshot.documents.length && !_isFirstFriendsFetch) {
          debugPrint('[친구] 친구 감소!!');

          for(DocumentChange decreasedChange in snapshot.documentChanges) {

            String blockedUserUID = decreasedChange.document.documentID;
            await sl.get<ServerChatAPI>().disconnectChatRoom(otherUserUID: blockedUserUID);

            UserModel otherUser = UserModel.fromSnapshot(snapshot: await _getUserInfo(blockedUserUID));
            if(_isFriends(otherUser)) {
              sl.get<FriendsBloc>().emitEvent(FriendsEventBlockFromServer(userToBlock: otherUser));
            }
          }
          sl.get<FriendsBloc>().emitEvent(FriendsEventFriendsDecreased(friends: snapshot.documentChanges));
        } 
        /// [친구 증가]
        else if(!_isFirstFriendsFetch){
          debugPrint('[친구] 친구 증가!!');

          for(DocumentChange increasedChange in snapshot.documentChanges) {
            DocumentSnapshot userSnapshot = await _getUserInfo(increasedChange.document.data[firestoreFriendsUID]);
            UserModel user = UserModel.fromSnapshot(snapshot: userSnapshot);
            await sl.get<ServerChatAPI>().connectChatRoom(otherUser: user);
          }
          sl.get<FriendsBloc>().emitEvent(FriendsEventFriendsIncreased(friends: snapshot.documentChanges));
        } 
        /// [처음]
        else {
          debugPrint('[친구] 처음, 친구 있음');

          _isFirstFriendsFetch = false;
          sl.get<FriendsBloc>().emitEvent(FriendsEventFirstFriendsFetch(friends: snapshot.documents));
        }
      } else {
        debugPrint('[친구] 처음, 친구 없음');
        
        _isFirstFriendsFetch = false;
      }
    });
  }

  /// [로그아웃 → 친구목록 해제]
  Future<void> disconnectFriendsList() async {
    debugPrint('[친구] 친구 목록 해제');

    await _friendsSubscription.cancel();
  }

  /// [친구 맞나 확인]
  bool _isFriends(UserModel otherUser) {
    debugPrint('[친구] 친구인지 확인');

    return sl.get<CurrentUser>().friendsList.where((user)
      => user.uid==otherUser.uid).isNotEmpty; 
  }

  /// [사용자 정보 가져오기]
  Future<DocumentSnapshot> _getUserInfo(String otherUserUID) async {
    debugPrint('[친구] $otherUserUID의 정보 가져오기');

    return 
      await sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreUsersCollection)
      .document(otherUserUID)
      .get();
  }
}