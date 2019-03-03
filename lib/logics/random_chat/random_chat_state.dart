import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class RandomChatState extends BlocState {
  final bool isInitial;
  final bool isSendMessageSucceeded;
  final bool isSendMessageFailed;
  final bool isGetOutSucceeded;
  final bool isGetOutFailed;
  final bool isChatFinished;

  final String sendingMessage;
  final DateTime sendingTimestamp;

  RandomChatState({
    this.isInitial:false,
    this.isSendMessageSucceeded: false,
    this.isSendMessageFailed: false,
    this.isGetOutSucceeded: false,
    this.isGetOutFailed: false,
    this.isChatFinished: false,
    this.sendingMessage: '',
    this.sendingTimestamp
  });

  factory RandomChatState.initial() {
    return RandomChatState(
      isInitial: true
    );
  }

  factory RandomChatState.showMessageFirst(String content, DateTime timestamp) {
    return RandomChatState(
      sendingMessage: content,
      sendingTimestamp: timestamp
    );
  }

  factory RandomChatState.sendMessageSucceeded() {
    return RandomChatState(
      isSendMessageSucceeded: true
    );
  }

  factory RandomChatState.sendMessageFailed() {
    return RandomChatState(
      isSendMessageFailed: true
    );
  }

  factory RandomChatState.getOutSucceeded() {
    return RandomChatState(
      isGetOutSucceeded: true
    );
  }

  factory RandomChatState.getOutFailed() {
    return RandomChatState(
      isGetOutFailed: true
    );
  }

  factory RandomChatState.chatFinished() {
    return RandomChatState(
      isChatFinished: true
    );
  }
}