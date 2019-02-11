import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class CelebrityState extends BlocState {
  final bool isLoading;
  final bool isSucceeded;

  CelebrityState({
    this.isLoading: false,
    this.isSucceeded: false
  });

  factory CelebrityState.loading() {
    return CelebrityState(
      isLoading: true
    );
  }

  factory CelebrityState.succeeded() {
    return CelebrityState(
      isSucceeded: true
    );
  }
}