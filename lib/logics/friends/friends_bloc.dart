import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/friends/friends.dart';

class FriendsBloc extends BlocEventStateBase<FriendsEvent,FriendsState>
{
  static final FriendsAPI _api = FriendsAPI();

  @override
  FriendsState get initialState => FriendsState.initial();

  @override
  Stream<FriendsState> eventHandler(FriendsEvent event, FriendsState currentState) async*{

    if(event is FriendsEventStateClear) {
      yield FriendsState();
    }

    if(event is FriendsEventFirstFriendsFetch) {
      try {
        yield FriendsState.firstFriendsFetchLoading();
        await _api.fetchFirstFriends(event.friends);
        yield FriendsState.firstFriendsFetchSucceeded();
      } catch(exception) {
        debugPrint('처음 친구 데이터 가져오기 실패: ${exception.toString()}');
        yield FriendsState.firstFriendsFetchFailed();
      }
    }

    if(event is FriendsEventFirstRequestFetch) {
      try {
        yield FriendsState.firstRequestFetchLoading();
        await _api.fetchFirstRequest(event.request);
        yield FriendsState.firstRequestFetchSucceeded();
      } catch(exception) {
        debugPrint('처음 데이터 가져오기 실패: ${exception.toString()}');
        yield FriendsState.firstRequestFetchFailed();
      }
    }

    if(event is FriendsEventFriendsNotification) {
      try {
        await _api.setFriendsNotification();
        yield FriendsState.friendsNotificationToggleSucceeded();
      } catch(exception) {
        debugPrint('알림설정 실패: ${exception.toString()}');
        yield FriendsState.friendsNotificationToggleFailed();
      }
    }

    if(event is FriendsEventFriendsIncreased) {
      yield FriendsState.friendsRefreshLoading();
      try {
        await _api.fetchIncreasedFriends(event.friends);
        _api.notifyNewFriends();
        yield FriendsState.friendsIncreased();
      } catch(exception) {
        debugPrint('친구증가 실패: ${exception.toString()}');
        yield FriendsState.friendsRefreshFailed();
      }
    }

    if(event is FriendsEventFriendsDecreased) {
      yield FriendsState.friendsRefreshLoading();
      try {
        await _api.fetchDecreasedFriends(event.friends);
        yield FriendsState.friendsDecreased();
      } catch(exception) {
        debugPrint('친구감소 실패: ${exception.toString()}');
        yield FriendsState.friendsRefreshFailed();
      }
    }

    if(event is FriendsEventRequestIncreased) {
      yield FriendsState.requestRefreshLoading();
      try {
        await _api.fetchIncreasedRequestFrom(event.request);
        _api.notifyNewRequestFrom();
        yield FriendsState.requestIncreased();
      } catch(exception) {
        debugPrint('친구신청 증가 실패: ${exception.toString()}');
        yield FriendsState.requestRefreshFailed();
      }
    }

    if(event is FriendsEventRequestDecreased) {
      yield FriendsState.requestRefreshLoading();
      try {
        await _api.fetchDecreasedRequestFrom(event.request);
        yield FriendsState.requestDecreased();
      } catch(exception) {
        debugPrint('친구신청 감소 실패: ${exception.toString()}');
        yield FriendsState.requestRefreshFailed();
      }
    }

    if(event is FriendsEventChat) {
      try {
        yield FriendsState.friendsChatLoading();
        String chatRoomID = await _api.chatWithFriends(event.user.uid);
        yield FriendsState.friendsChatSucceeded(chatRoomID,event.user);
      } catch(exception){
        debugPrint('친구에게 대화하기 실패: ${exception.toString()}');
        yield FriendsState.friendsChatFailed();
      }
    }

    /// [친구 차단]
    /// 서버와 로컬에서 전부 갱신
    if(event is FriendsEventBlockFromLocal) {
      try {
        yield FriendsState.friendsBlockLoading();
        await _api.blockFriendsForServer(event.userToBlock);
        yield FriendsState.friendsBlockSucceeded();
      } catch(exception) {
        debugPrint('친구차단하기 실패: ${exception.toString()}');
        yield FriendsState.friendsBlockFailed();
      }
    }

    /// [친구 수락]
    /// 서버와 로컬에서 전부 갱신
    if(event is FriendsEventAcceptFromLocal) {
      try {
        yield FriendsState.friendsAcceptLoading();
        await _api.acceptFriendsForServer(event.userToAccept);
        yield FriendsState.friendsAcceptSucceeded();
      } catch(exception) {
        debugPrint('친구수락하기 실패: ${exception.toString()}');
        yield FriendsState.friendsAcceptFailed();
      }
    }

    /// [친구신청 삭제]
    /// 서버와 로컬에서 전부 삭제
    if(event is FriendsEventRejectFromLocal) {
      try {
        yield FriendsState.friendsRejectLoading();
        await _api.rejectFriendsForServer(event.userToReject);
        yield FriendsState.friendsRejectSucceeded();
      } catch(exception) {
        debugPrint('친구삭제하기 실패: ${exception.toString()}');
        yield FriendsState.friendsRejectFailed();
      }
    }
  }
}