import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class RandomChatState extends BlocState {
  final bool isInitial;
  final bool isLoading;
  final bool matchCompleted;
  final bool matchFailed;

  RandomChatState({
    this.isInitial:false,
    this.isLoading: false,
    this.matchCompleted: false,
    this.matchFailed: false
  });

  factory RandomChatState.loading() {
    return RandomChatState(
      isLoading: true
    );
  }

  factory RandomChatState.matchSucceeded() {
    return RandomChatState(
      matchCompleted: true
    );
  }
}