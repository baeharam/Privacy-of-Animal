import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/models/user_model.dart';

class FriendsState extends BlocState {
  final bool isInitial;

  final bool isFriendsFetchLoading;
  final bool isFriendsFetchSucceeded;
  final bool isFriendsFetchFailed;
  
  final bool isFriendsChatLoading;
  final bool isFriendsChatSucceeded;
  final bool isFriendsChatFailed;

  final bool isFriendsBlockLoading;
  final bool isFriendsBlockSucceeded;
  final bool isFriendsBlockFailed;

  final bool isFriendsRequestFetchLoading;
  final bool isFriendsRequestFetchSucceeded;
  final bool isFriendsRequestFetchFailed;

  final bool isFriendsAcceptLoading;
  final bool isFriendsAcceptSucceeded;
  final bool isFriendsAcceptFailed;

  final bool isFriendsRejectLoading;
  final bool isFriendsRejectSucceeded;
  final bool isFriendsRejectFailed;

  final bool isFriendsAcceptedNotification;

  final String chatRoomID;
  final UserModel receiver;

  FriendsState({
    this.isInitial: false,

    this.isFriendsFetchLoading: false,
    this.isFriendsFetchSucceeded: false,
    this.isFriendsFetchFailed: false,
    
    this.isFriendsChatLoading: false,
    this.isFriendsChatSucceeded: false,
    this.isFriendsChatFailed: false,

    this.isFriendsBlockLoading: false,
    this.isFriendsBlockSucceeded: false,
    this.isFriendsBlockFailed: false,

    this.isFriendsRequestFetchLoading: false,
    this.isFriendsRequestFetchSucceeded: false,
    this.isFriendsRequestFetchFailed: false,

    this.isFriendsAcceptLoading: false,
    this.isFriendsAcceptSucceeded: false,
    this.isFriendsAcceptFailed: false,

    this.isFriendsRejectLoading: false,
    this.isFriendsRejectSucceeded: false,
    this.isFriendsRejectFailed: false,

    this.isFriendsAcceptedNotification: false,

    this.chatRoomID: '',
    this.receiver,
  });

  factory FriendsState.initial() {
    return FriendsState(
      isInitial: true
    );
  }
  
  factory FriendsState.friendsFetchLoading()  => FriendsState(isFriendsFetchLoading: true);
  factory FriendsState.friendsFetchSuceeded()  => FriendsState(isFriendsFetchSucceeded: true);
  factory FriendsState.friendsFetchFailed()  => FriendsState(isFriendsFetchFailed: true);

  factory FriendsState.friendsChatLoading() => FriendsState(isFriendsChatLoading: true);
  factory FriendsState.friendsChatSucceeded(String chatRoomID, UserModel receiver) {
    return FriendsState(
      isFriendsChatSucceeded: true,
      chatRoomID: chatRoomID,
      receiver: receiver
    );
  }
  factory FriendsState.friendsChatFailed() => FriendsState(isFriendsChatFailed: true);

  factory FriendsState.friendsBlockLoading() => FriendsState(isFriendsBlockLoading: true);
  factory FriendsState.friendsBlockSucceeded() => FriendsState(isFriendsBlockSucceeded: true);
  factory FriendsState.friendsBlockFailed() => FriendsState(isFriendsBlockFailed: true);

  factory FriendsState.friendsRequestFetchLoading() => FriendsState(isFriendsRequestFetchLoading: true);
  factory FriendsState.friendsRequestFetchSucceeded() => FriendsState(isFriendsRequestFetchSucceeded: true);
  factory FriendsState.friendsRequestFetchFailed() => FriendsState(isFriendsRequestFetchFailed: true);

  factory FriendsState.friendsAcceptLoading() => FriendsState(isFriendsAcceptLoading: true);
  factory FriendsState.friendsAcceptSucceeded() => FriendsState(isFriendsAcceptSucceeded: true);
  factory FriendsState.friendsAcceptFailed() => FriendsState(isFriendsAcceptFailed: true);

  factory FriendsState.friendsRejectLoading() => FriendsState(isFriendsRejectLoading: true);
  factory FriendsState.friendsRejectSucceeded() => FriendsState(isFriendsRejectSucceeded: true);
  factory FriendsState.friendsRejectFailed() => FriendsState(isFriendsRejectFailed: true);

  factory FriendsState.friendsAcceptedNotify() {
    return FriendsState(
      isFriendsAcceptedNotification: true
    );
  }
  
}