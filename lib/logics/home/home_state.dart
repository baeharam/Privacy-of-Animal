
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class HomeState extends BlocState {
  final bool isMatchClicked;
  final bool isChatClicked;
  final bool isFriendClicked;
  final bool isProfileClicked;

  final bool isProfileFetchLoading;
  final bool isProfileFetchFailed;

  final bool isFriendsFetchLoading;
  final bool isFriendsFetchFailed;

  final int activeIndex;

  HomeState({
    this.isMatchClicked: false,
    this.isChatClicked: false,
    this.isFriendClicked: false,
    this.isProfileClicked: false,
    
    this.isProfileFetchLoading: false,
    this.isProfileFetchFailed: false,

    this.isFriendsFetchLoading: false,
    this.isFriendsFetchFailed: false,

    this.activeIndex: 0
  });

  factory HomeState.match(int index) {
    return HomeState(
      isMatchClicked: true,
      activeIndex: index
    );
  }

  factory HomeState.chat(int index) {
    return HomeState(
      isChatClicked: true,
      activeIndex: index
    );
  }

  factory HomeState.friend(int index) {
    return HomeState(
      isFriendClicked: true,
      activeIndex: index
    );
  }

  factory HomeState.profile(int index) {
    return HomeState(
      isProfileClicked: true,
      activeIndex: index
    );
  }

  factory HomeState.profileLoading(int index) {
    return HomeState(
      isProfileFetchLoading: true,
      activeIndex: index
    );
  }

  factory HomeState.friendsLoading(int index) {
    return HomeState(
      isFriendsFetchLoading: true,
      activeIndex: index
    );
  }

  factory HomeState.profileFailed() => HomeState(isProfileFetchFailed: true);
  factory HomeState.friendsFailed() => HomeState(isFriendsFetchFailed: true);
}