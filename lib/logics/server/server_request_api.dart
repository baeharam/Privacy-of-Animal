import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/logics/friends/friends.dart';
import 'package:privacy_of_animal/logics/other_profile/other_profile.dart';
import 'package:privacy_of_animal/logics/same_match/same_match.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:rxdart/rxdart.dart';

class ServerRequestAPI {
  static bool _isFirstRequestFetch = true;

  Observable<QuerySnapshot> _requestFromServer;
  StreamSubscription _requestFromSubscription;

  StreamSubscription _requestToSubscription;

  ServerRequestAPI() {
    _requestFromServer = Observable.empty();
    _requestFromSubscription = _requestFromServer.listen((_){});

    _requestToSubscription = Observable.empty().listen((_){});
  }

  /// [매칭화면 → 이미 친구신청 했는지 확인 스트림 연결]
  void connectRequestToStream({@required String otherUserUID}) {
    debugPrint('[친구] $otherUserUID에게 친구신청하는지 확인하기 위한 연결');

    Stream<QuerySnapshot> requestStreamTo = 
      sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreUsersCollection)
      .document(otherUserUID)
      .collection(firestoreFriendsSubCollection)
      .where(firestoreFriendsUID, isEqualTo: sl.get<CurrentUser>().uid)
      .where(firestoreFriendsField, isEqualTo: false).snapshots();
    _requestToSubscription = requestStreamTo.listen((requestSnapshot){
      if(requestSnapshot.documents
        .where((snapshot) => snapshot.documentID==sl.get<CurrentUser>().uid).isEmpty) {
        sl.get<CurrentUser>().isRequestTo = false;
        sl.get<SameMatchBloc>().emitEvent(SameMatchEventRefreshRequestTo());
        sl.get<OtherProfileBloc>().emitEvent(OtherProfileEventRefreshRequestTo());
      }
    });
  }
  /// [매칭화면 → 이미 친구신청 했는지 확인 스트림 취소]
  Future<void> disconnectRequestToStream({@required String otherUserUID}) async{
    debugPrint('[친구] $otherUserUID에게 친구신청했는지 확인하는 연결 취소');

    await _requestToSubscription.cancel();
  }

  /// [로그인 → 친구신청목록 연결]
  Future<void> connectRequestFromList() async {
    debugPrint('[친구] 친구신청 목록 스트림 연결');

    _requestFromServer = Observable(
      sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreUsersCollection)
      .document(sl.get<CurrentUser>().uid)
      .collection(firestoreFriendsSubCollection)
      .where(firestoreFriendsField, isEqualTo: false)
      .snapshots()
    );
    _requestFromSubscription = _requestFromServer.listen((snapshot) async{
      if(snapshot.documentChanges.isNotEmpty) {

        /// [친구신청 증가]
        if(sl.get<CurrentUser>().requestFromList.length < snapshot.documents.length
          && !_isFirstRequestFetch) {
            debugPrint('[친구] 친구신청 증가!!');

            sl.get<FriendsBloc>().emitEvent(
              FriendsEventRequestIncreased(request: snapshot.documentChanges)
            );
          } 
        /// [친구신청 감소]
        else if(!_isFirstRequestFetch){
          debugPrint('[친구] 친구신청 감소!!');

          sl.get<FriendsBloc>().emitEvent(
            FriendsEventRequestDecreased(request: snapshot.documentChanges)
          );
        }
        /// [처음]
        else {
          debugPrint('[친구] 처음, 친구신청 있음');

          _isFirstRequestFetch = false;
          sl.get<FriendsBloc>().emitEvent(
            FriendsEventFirstRequestFetch(request: snapshot.documents)
          );
        }
      } 
      /// [처음]
      else {
        debugPrint('[친구] 처음, 친구신청 없음');

        _isFirstRequestFetch = false;
      }
    });
  }

  /// [로그아웃 → 친구신청목록 해제]
  Future<void> disconnectRequestFromList() async {
    debugPrint('[친구] 친구신청 목록 해제');

    await _requestFromSubscription.cancel();
  }
}