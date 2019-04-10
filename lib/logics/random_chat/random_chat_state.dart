import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class RandomChatState extends BlocState {
  final bool isInitial;

  final bool isSendMessageSucceeded;
  final bool isSendMessageFailed;

  final bool isGetOutSucceeded;
  final bool isGetOutFailed;

  final bool isChatFinished;

  final bool isMessageReceived;

  RandomChatState({
    this.isInitial:false,

    this.isSendMessageSucceeded: false,
    this.isSendMessageFailed: false,

    this.isGetOutSucceeded: false,
    this.isGetOutFailed: false,

    this.isChatFinished: false,

    this.isMessageReceived: false,
  });

  factory RandomChatState.initial() => RandomChatState(isInitial: true);

  factory RandomChatState.sendMessageSucceeded() => RandomChatState(isSendMessageSucceeded: true);
  factory RandomChatState.sendMessageFailed() => RandomChatState(isSendMessageFailed: true);

  factory RandomChatState.getOutSucceeded() => RandomChatState(isGetOutSucceeded: true);
  factory RandomChatState.getOutFailed() => RandomChatState(isGetOutFailed: true);

  factory RandomChatState.chatFinished() => RandomChatState(isChatFinished: true);

  factory RandomChatState.messageReceived() => RandomChatState(isMessageReceived: true);
}