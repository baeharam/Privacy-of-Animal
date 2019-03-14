import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/models/user_model.dart';

class FriendsState extends BlocState {
  final bool isInitial;
  final bool isLoading;
  final bool isFriendsFetchSucceeded;
  final bool isFriendsFetchFailed;
  final bool isFriendsBlockSucceeded;
  final bool isFriendsBlockFailed;
  final bool isFriendsChatSucceeded;
  final bool isFriendsChatFailed;

  final bool isFriendsRequestFetchSucceeded;
  final bool isFriendsRequestFetchFailed;
  final bool isFriendsAcceptSucceeded;
  final bool isFriendsAcceptFailed;
  final bool isFriendsRejectSucceeded;
  final bool isFriendsRejectFailed;

  final bool isFriendsAcceptedNotification;

  final List<UserModel> friends;
  final List<UserModel> friendsRequest;
  final String chatRoomID;
  final UserModel receiver;

  FriendsState({
    this.isInitial: false,
    this.isLoading: false,
    this.isFriendsFetchSucceeded: false,
    this.isFriendsFetchFailed: false,
    this.isFriendsBlockSucceeded: false,
    this.isFriendsBlockFailed: false,
    this.isFriendsChatSucceeded: false,
    this.isFriendsChatFailed: false,

    this.isFriendsRequestFetchSucceeded: false,
    this.isFriendsRequestFetchFailed: false,
    this.isFriendsAcceptSucceeded: false,
    this.isFriendsAcceptFailed: false,
    this.isFriendsRejectSucceeded: false,
    this.isFriendsRejectFailed: false,

    this.isFriendsAcceptedNotification: false,

    this.friends,
    this.friendsRequest,
    this.chatRoomID: '',
    this.receiver,
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

  factory FriendsState.friendsFetchSuceeded(List<UserModel> friends) {
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

  factory FriendsState.friendsChatSucceeded(String chatRoomID, UserModel receiver) {
    return FriendsState(
      isFriendsChatSucceeded: true,
      chatRoomID: chatRoomID,
      receiver: receiver
    );
  }

  factory FriendsState.friendsChatFailed() {
    return FriendsState(
      isFriendsChatFailed: true
    );
  }

  factory FriendsState.friendsBlockSucceeded() {
    return FriendsState(
      isFriendsBlockSucceeded: true
    );
  }

  factory FriendsState.friendsBlockFailed() {
    return FriendsState(
      isFriendsBlockFailed: true
    );
  }

  factory FriendsState.friendsRequestFetchSucceeded(List<UserModel> friendsRequest) {
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

  factory FriendsState.friendsAcceptedNotify() {
    return FriendsState(
      isFriendsAcceptedNotification: true
    );
  }
  
}