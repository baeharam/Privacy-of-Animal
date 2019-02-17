import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class FriendsState extends BlocState {
  final bool isInitial;
  final bool isLoading;
  final bool isFriendsFetchSucceeded;
  final bool isFriendsFetchFailed;
  final bool isFriendsRequestFetchSucceeded;
  final bool isFriendsRequestFetchFailed;
  final bool isFriendsAcceptSucceeded;
  final bool isFriendsAcceptFailed;
  final bool isFriendsRejectSucceeded;
  final bool isFriendsRejectFailed;

  final List<DocumentSnapshot> friends;
  final List<DocumentSnapshot> friendsRequest;

  FriendsState({
    this.isInitial: false,
    this.isLoading: false,
    this.isFriendsFetchSucceeded: false,
    this.isFriendsFetchFailed: false,
    this.isFriendsRequestFetchSucceeded: false,
    this.isFriendsRequestFetchFailed: false,

    this.isFriendsAcceptSucceeded: false,
    this.isFriendsAcceptFailed: false,
    this.isFriendsRejectSucceeded: false,
    this.isFriendsRejectFailed: false,

    this.friends,
    this.friendsRequest
  });

  factory FriendsState.initial() {
    return FriendsState(
      isInitial: true
    );
  }

  factory FriendsState.loading() {
    return FriendsState(
      isLoading: true
    );
  }

  factory FriendsState.friendsFetchSuceeded(List<DocumentSnapshot> friends) {
    return FriendsState(
      isFriendsFetchSucceeded: true,
      friends: friends
    );
  }

  factory FriendsState.friendsFetchFailed() {
    return FriendsState(
      isFriendsFetchFailed: true
    );
  }

  factory FriendsState.friendsRequestFetchSucceeded(List<DocumentSnapshot> friendsRequest) {
    return FriendsState(
      isFriendsRequestFetchSucceeded: true,
      friendsRequest: friendsRequest
    );
  }

  factory FriendsState.friendsRequestFetchFailed() {
    return FriendsState(
      isFriendsRequestFetchFailed: true
    );
  }

  factory FriendsState.friendsAcceptSucceeded() {
    return FriendsState(
      isFriendsAcceptSucceeded: true
    );
  }

  factory FriendsState.friendsAcceptFailed() {
    return FriendsState(
      isFriendsAcceptSucceeded: true
    );
  }

  factory FriendsState.friendsRejectSucceeded() {
    return FriendsState(
      isFriendsRejectSucceeded: true
    );
  }

  factory FriendsState.friendsRejectFailed() {
    return FriendsState(
      isFriendsRejectFailed: true
    );
  }
  
}