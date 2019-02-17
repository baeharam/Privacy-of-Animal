import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/friends/friends.dart';

class FriendsBloc extends BlocEventStateBase<FriendsEvent,FriendsState>
{
  static final FriendsAPI _api = FriendsAPI();

  @override
  FriendsState get initialState => FriendsState.initial();

  @override
  Stream<FriendsState> eventHandler(FriendsEvent event, FriendsState currentState) async*{
    if(event is FriendsEventFetchFriendsList) {
      yield FriendsState.loading();
      try {
        List<DocumentSnapshot> friends = await _api.fetchFriendsList(event.friends);
        yield FriendsState.friendsFetchSuceeded(friends);
      } catch(exception){
        print(exception);
        yield FriendsState.friendsFetchFailed();
      }
    }

    if(event is FriendsEventFetchFriendsRequestList) {
      yield FriendsState.loading();
      try {
        List<DocumentSnapshot> friends = await _api.fetchFriendsList(event.friendsRequest);
        yield FriendsState.friendsRequestFetchSucceeded(friends);
      } catch(exception){
        print(exception);
        yield FriendsState.friendsRequestFetchFailed();
      }
    }

    if(event is FriendsEventChat) {
      try {
        String chatRoomID = await _api.chatWithFriends(event.user.documentID);
        yield FriendsState.friendsChatSucceeded(chatRoomID,event.user);
      } catch(exception){
        print(exception);
        yield FriendsState.friendsChatFailed();
      }
    }

    if(event is FriendsEventBlock) {
      try {
        await _api.blockFriends(event.user);
        yield FriendsState.friendsBlockSucceeded();
      } catch(exception) {
        print(exception);
        yield FriendsState.friendsBlockFailed();
      }
    }

    if(event is FriendsEventRequestAccept) {
      try {
        await _api.acceptFriendsRequest(event.user);
        yield FriendsState.friendsAcceptSucceeded();
      } catch(exception) {
        print(exception);
        yield FriendsState.friendsAcceptFailed();
      }
    }

    if(event is FriendsEventRequestReject) {
      try {
        await _api.rejectFriendsRequest(event.user);
        yield FriendsState.friendsRejectSucceeded();
      } catch(exception) {
        print(exception);
        yield FriendsState.friendsRejectFailed();
      }
    }
  }
}