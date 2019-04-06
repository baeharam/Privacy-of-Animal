import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/models/user_model.dart';

class FriendsState extends BlocState {
  final bool isInitial;

  // 처음 친구 데이터 가져오기
  final bool isFirstFriendsFetchLoading;
  final bool isFirstFriendsFetchSucceeded;
  final bool isFirstFriendsFetchFailed;

  // 처음 친구 데이터 가져오기
  final bool isFirstRequestFetchLoading;
  final bool isFirstRequestFetchSucceeded;
  final bool isFirstRequestFetchFailed;

  // 친구 증가/감소에 대해서 갱신
  final bool isFriendsRefreshLoading;
  final bool isFriendsIncreased;
  final bool isFriendsDecreased;
  final bool isFriendsRefreshFailed;

  // 친구신청 증가/감소에 대해서 갱신
  final bool isRequestRefreshLoading;
  final bool isRequestIncreased;
  final bool isRequestDecreased;
  final bool isRequestRefreshFailed;
  
  // 친구와의 채팅
  final bool isFriendsChatLoading;
  final bool isFriendsChatSucceeded;
  final bool isFriendsChatFailed;

  // 친구 차단
  final bool isFriendsBlockLoading;
  final bool isFriendsBlockSucceeded;
  final bool isFriendsBlockFailed;

  // 친구신청 수락
  final bool isFriendsAcceptLoading;
  final bool isFriendsAcceptSucceeded;
  final bool isFriendsAcceptFailed;

  // 친구신청 거절
  final bool isFriendsRejectLoading;
  final bool isFriendsRejectSucceeded;
  final bool isFriendsRejectFailed;

  final bool isNewFriends;

  // 친구와 친구신청 알람설정
  final bool isFriendsNotificationToggleSucceeded;
  final bool isFriendsNotificationToggleFailed;

  final String chatRoomID;
  final UserModel receiver;

  FriendsState({
    this.isInitial: false,

    this.isFirstFriendsFetchLoading: false,
    this.isFirstFriendsFetchSucceeded: false,
    this.isFirstFriendsFetchFailed: false,

    this.isFirstRequestFetchLoading: false,
    this.isFirstRequestFetchSucceeded: false,
    this.isFirstRequestFetchFailed: false,

    this.isFriendsRefreshLoading: false,
    this.isFriendsIncreased: false,
    this.isFriendsDecreased: false,
    this.isFriendsRefreshFailed: false,
    
    this.isFriendsChatLoading: false,
    this.isFriendsChatSucceeded: false,
    this.isFriendsChatFailed: false,

    this.isFriendsBlockLoading: false,
    this.isFriendsBlockSucceeded: false,
    this.isFriendsBlockFailed: false,

    this.isRequestRefreshLoading: false,
    this.isRequestIncreased: false,
    this.isRequestDecreased: false,
    this.isRequestRefreshFailed: false,

    this.isFriendsAcceptLoading: false,
    this.isFriendsAcceptSucceeded: false,
    this.isFriendsAcceptFailed: false,

    this.isFriendsRejectLoading: false,
    this.isFriendsRejectSucceeded: false,
    this.isFriendsRejectFailed: false,

    this.isNewFriends: false,

    this.isFriendsNotificationToggleSucceeded: false,
    this.isFriendsNotificationToggleFailed: false,

    this.chatRoomID: '',
    this.receiver,
  });

  factory FriendsState.initial() => FriendsState(isInitial: true);

  factory FriendsState.firstFriendsFetchLoading() => FriendsState(isFirstFriendsFetchLoading: true);
  factory FriendsState.firstFriendsFetchSucceeded() => FriendsState(isFirstFriendsFetchSucceeded: true);
  factory FriendsState.firstFriendsFetchFailed() => FriendsState(isFirstFriendsFetchFailed: true);

  factory FriendsState.firstRequestFetchLoading() => FriendsState(isFirstRequestFetchLoading: true);
  factory FriendsState.firstRequestFetchSucceeded() => FriendsState(isFirstRequestFetchSucceeded: true);
  factory FriendsState.firstRequestFetchFailed() => FriendsState(isFirstRequestFetchFailed: true);
  
  factory FriendsState.friendsRefreshLoading() => FriendsState(isFriendsRefreshLoading: true);
  factory FriendsState.friendsIncreased() => FriendsState(isFriendsIncreased: true);
  factory FriendsState.friendsDecreased() => FriendsState(isFriendsDecreased: true);
  factory FriendsState.friendsRefreshFailed() => FriendsState(isFriendsRefreshFailed: true);

  factory FriendsState.requestRefreshLoading() => FriendsState(isRequestRefreshLoading: true);
  factory FriendsState.requestIncreased() => FriendsState(isRequestIncreased: true);
  factory FriendsState.requestDecreased() => FriendsState(isRequestDecreased: true);
  factory FriendsState.requestRefreshFailed() => FriendsState(isRequestRefreshFailed: true);

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

  factory FriendsState.friendsAcceptLoading() => FriendsState(isFriendsAcceptLoading: true);
  factory FriendsState.friendsAcceptSucceeded() => FriendsState(isFriendsAcceptSucceeded: true);
  factory FriendsState.friendsAcceptFailed() => FriendsState(isFriendsAcceptFailed: true);

  factory FriendsState.friendsRejectLoading() => FriendsState(isFriendsRejectLoading: true);
  factory FriendsState.friendsRejectSucceeded() => FriendsState(isFriendsRejectSucceeded: true);
  factory FriendsState.friendsRejectFailed() => FriendsState(isFriendsRejectFailed: true);

  factory FriendsState.newFriends() => FriendsState(isNewFriends: true);

  factory FriendsState.friendsNotificationToggleSucceeded() 
    => FriendsState(isFriendsNotificationToggleSucceeded: true);
  factory FriendsState.friendsNotificationToggleFailed() 
    => FriendsState(isFriendsNotificationToggleFailed: true);
}