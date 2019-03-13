
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class HomeState extends BlocState {
  final bool isMatchClicked;
  final bool isChatClicked;
  final bool isFriendClicked;
  final bool isProfileClicked;
  final bool isFetchLoading;
  final bool isFetchFailed;

  final int activeIndex;

  HomeState({
    this.isMatchClicked: false,
    this.isChatClicked: false,
    this.isFriendClicked: false,
    this.isProfileClicked: false,
    this.isFetchLoading: false,
    this.isFetchFailed: false,
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

  factory HomeState.loading(int index) {
    return HomeState(
      isFetchLoading: true,
      activeIndex: index
    );
  }

  factory HomeState.failed() => HomeState(isFetchFailed: true);
}