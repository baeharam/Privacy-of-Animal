import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class IntroState extends BlocState {
  final bool isPage1;
  final bool isPage2;
  final bool isPage3;

  IntroState({
    this.isPage1: true,
    this.isPage2: false,
    this.isPage3: false
  });

  factory IntroState.page1() {
    return IntroState(
      isPage1: true,
      isPage2: false,
      isPage3: false
    );
  }

  factory IntroState.page2() {
    return IntroState(
      isPage1: false,
      isPage2: true,
      isPage3: false
    );
  }

  factory IntroState.page3() {
    return IntroState(
      isPage1: false,
      isPage2: false,
      isPage3: true
    );
  }
}