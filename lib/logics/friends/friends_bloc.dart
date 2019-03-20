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
      yield FriendsState.initial();
    }

    if(event is FriendsEventFetchFriendsList) {
      yield FriendsState.friendsFetchLoading();
      try {
        await _api.fetchFriendsList(event.friends,isFriendsList: true);
        yield FriendsState.friendsFetchSuceeded();
      } catch(exception){
        print('친구목록 불러오기 실패: ${exception.toString()}');
        yield FriendsState.friendsFetchFailed();
      }
    }

    if(event is FriendsEventFetchFriendsRequestList) {
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

    if(event is FriendsEventBlock) {
      try {
        yield FriendsState.friendsBlockLoading();
        await _api.blockFriends(event.user);
        yield FriendsState.friendsBlockSucceeded();
      } catch(exception) {
        print('친구차단하기 실패: ${exception.toString()}');
        yield FriendsState.friendsBlockFailed();
      }
    }

    if(event is FriendsEventRequestAccept) {
      try {
        yield FriendsState.friendsAcceptLoading();
        await _api.acceptFriendsRequest(event.user);
        yield FriendsState.friendsAcceptSucceeded();
      } catch(exception) {
        print('친구수락하기 실패: ${exception.toString()}');
        yield FriendsState.friendsAcceptFailed();
      }
    }

    if(event is FriendsEventRequestReject) {
      try {
        yield FriendsState.friendsRejectLoading();
        await _api.rejectFriendsRequest(event.user);
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