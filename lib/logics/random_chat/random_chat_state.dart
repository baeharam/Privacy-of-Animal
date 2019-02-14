import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class RandomChatState extends BlocState {
  final bool isInitial;
  final bool isLoading;
  final bool isChatRoomMade;
  final bool matchCompleted;
  final bool matchFailed;
  final bool isCanceled;

  final String chatRoomID;

  RandomChatState({
    this.isInitial:false,
    this.isLoading: false,
    this.isChatRoomMade: false,
    this.matchCompleted: false,
    this.matchFailed: false,
    this.isCanceled: false,
    this.chatRoomID: ''
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

  factory RandomChatState.madeChatRoom(String chatRoomID) {
    return RandomChatState(
      isChatRoomMade: true,
      chatRoomID: chatRoomID
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