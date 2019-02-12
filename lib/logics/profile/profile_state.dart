import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class ProfileState extends BlocState {
  final bool isInitial;
  final bool isResetPossible;
  final bool isResetImpossible;
  final String remainedTime;

  ProfileState({
    this.isInitial: false,
    this.isResetPossible: false,
    this.isResetImpossible: false,
    this.remainedTime: ''
  });

  factory ProfileState.initial() {
    return ProfileState(
      isInitial: true
    );
  }

  factory ProfileState.reset() {
    return ProfileState(
      isResetPossible: true
    );
  }

  factory ProfileState.noReset(String time) {
    return ProfileState(
      isResetImpossible: true,
      remainedTime: time
    );
  }
}