import 'dart:async';

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

    if(event is FriendsEventFriendsNotification) {
      try {
        await _api.setFriendsNotification();
        yield FriendsState.friendsNotificationToggleSucceeded();
      } catch(exception) {
        print('알림설정 실패: ${exception.toString()}');
        yield FriendsState.friendsNotificationToggleFailed();
      }
    }

    if(event is FriendsEventRefreshFriends) {
      yield FriendsState.friendsFetchLoading();
      try {
        await _api.fetchFriendsList(event.friends,isFriendsList: true);
        yield FriendsState.friendsFetchSuceeded();
      } catch(exception){
        print('친구목록 불러오기 실패: ${exception.toString()}');
        yield FriendsState.friendsFetchFailed();
      }
    }

    if(event is FriendsEventRefreshRequest) {
      yield FriendsState.friendsRequestFetchLoading();
      try {
        await _api.fetchFriendsList(event.friendsRequest,isFriendsList: false);
        yield FriendsState.friendsRequestFetchSucceeded();
      } catch(exception){
        print('친구신청목록 불러오기 실패: ${exception.toString()}');
        yield FriendsState.friendsRequestFetchFailed();
      }
    }

    if(event is FriendsEventChat) {
      try {
        yield FriendsState.friendsChatLoading();
        String chatRoomID = await _api.chatWithFriends(event.user.uid);
        yield FriendsState.friendsChatSucceeded(chatRoomID,event.user);
      } catch(exception){
        print('친구에게 대화하기 실패: ${exception.toString()}');
        yield FriendsState.friendsChatFailed();
      }
    }

    /// [친구 차단]
    /// 서버와 로컬에서 전부 갱신
    if(event is FriendsEventBlockFromLocal) {
      try {
        yield FriendsState.friendsBlockLoading();
        await _api.blockFriendsForServer(event.user);
      } catch(exception) {
        print('친구차단하기 실패: ${exception.toString()}');
        yield FriendsState.friendsBlockFailed();
      }
    }

    if(event is FriendsEventBlockFromServer) {
      _api.blockFriendsForLocal(event.userToBlock);
      yield FriendsState.friendsBlockSucceeded();
    }

    /// [친구 수락]
    /// 서버와 로컬에서 전부 갱신
    if(event is FriendsEventAcceptFromLocal) {
      try {
        yield FriendsState.friendsAcceptLoading();
        await _api.acceptFriendsForServer(event.userToAccept);
      } catch(exception) {
        print('친구수락하기 실패: ${exception.toString()}');
        yield FriendsState.friendsAcceptFailed();
      }
    }

    if(event is FriendsEventAcceptFromServer) {
      _api.acceptFriendsForLocal(event.userToAccept);
      yield FriendsState.friendsAcceptSucceeded();
    }

    /// [친구신청 삭제]
    /// 서버와 로컬에서 전부 삭제
    if(event is FriendsEventRejectFromLocal) {
      try {
        yield FriendsState.friendsRejectLoading();
        await _api.rejectFriendsForServer(event.userToReject);
        _api.rejectFriendsForLocal(event.userToReject);
        yield FriendsState.friendsRejectSucceeded();
      } catch(exception) {
        print('친구삭제하기 실패: ${exception.toString()}');
        yield FriendsState.friendsRejectFailed();
      }
    }

    if(event is FriendsEventNewFriends) {
      _api.updateNewFriends(event.newFriendsNum);
      yield FriendsState.newFriends();
    }
  }
}