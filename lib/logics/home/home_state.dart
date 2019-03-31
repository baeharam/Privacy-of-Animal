
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class HomeState extends BlocState {
  final bool isInitial;

  final bool isMatchClicked;
  final bool isChatClicked;
  final bool isFriendClicked;
  final bool isProfileClicked;

  final bool isDataFetchLoading;
  final bool isDataFetchFailed;

  final int activeIndex;

  HomeState({
    this.isInitial: false,

    this.isMatchClicked: false,
    this.isChatClicked: false,
    this.isFriendClicked: false,
    this.isProfileClicked: false,

    this.isDataFetchLoading: false,
    this.isDataFetchFailed: false,

    this.activeIndex: 0
  });

  factory HomeState.initial() => HomeState(isInitial: true);

  factory HomeState.fetchLoading() => HomeState(isDataFetchLoading: true);
  factory HomeState.fetchFailed() => HomeState(isDataFetchFailed: true);

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
}