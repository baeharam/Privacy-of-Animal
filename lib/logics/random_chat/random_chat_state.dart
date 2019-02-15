import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class RandomChatState extends BlocState {
  final bool isInitial;
  final bool isLoading;
  final bool isMatched;
  final bool isCanceled;
  final bool isAPIFailed;
  final bool isChatRoomMade;

  final String errorMessage;
  final String chatRoomID;
  final String receiver;

  RandomChatState({
    this.isInitial:false,
    this.isLoading: false,
    this.isChatRoomMade: false,
    this.isMatched: false,
    this.isAPIFailed: false,
    this.isCanceled: false,
    this.chatRoomID: '',
    this.errorMessage: '',
    this.receiver: ''
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
      isMatched: true,
      chatRoomID: chatRoomID,
      receiver: receiver
    );
  }

  factory RandomChatState.apiFailed(String error) {
    return RandomChatState(
      isAPIFailed: true,
      errorMessage: error
    );
  }

  factory RandomChatState.cancel() {
    return RandomChatState(
      isCanceled: true
    );
  }
}