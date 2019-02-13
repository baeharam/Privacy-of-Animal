import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class RandomChatState extends BlocState {
  final bool isInitial;
  final bool isLoading;
  final bool matchCompleted;
  final bool matchFailed;
  final bool isCanceled;

  RandomChatState({
    this.isInitial:false,
    this.isLoading: false,
    this.matchCompleted: false,
    this.matchFailed: false,
    this.isCanceled: false,
  });

  factory RandomChatState.initial() {
    return RandomChatState(
      isInitial: true
    );
  }

  factory RandomChatState.loading() {
    return RandomChatState(
      isLoading: true
    );
  }

  factory RandomChatState.matchSucceeded({String chatRoomID, String receiver}) {
    return RandomChatState(
      matchCompleted: true,
    );
  }

  factory RandomChatState.cancel() {
    return RandomChatState(
      isCanceled: true
    );
  }
}