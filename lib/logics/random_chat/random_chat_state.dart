import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class RandomChatState extends BlocState {
  final bool isInitial;
  final bool isLoading;
  final bool matched;
  final bool isCanceled;

  final bool apiFailed;
  final String errorMessage;

  final bool isChatRoomMade;
  final String chatRoomID;

  RandomChatState({
    this.isInitial:false,
    this.isLoading: false,
    this.isChatRoomMade: false,
    this.matched: false,
    this.apiFailed: false,
    this.errorMessage: '',
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
      matched: true,
    );
  }

  factory RandomChatState.apiFailed(String error) {
    return RandomChatState(
      apiFailed: true,
      errorMessage: error
    );
  }

  factory RandomChatState.cancel() {
    return RandomChatState(
      isCanceled: true
    );
  }
}