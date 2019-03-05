import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class TagChatState extends BlocState {
  final bool isInitial;

  final bool isFetchTagsFailed;

  final bool isIntroChat;
  final bool isIntroChatBegin;
  final bool isIntroChatEnd;
  final String introChat;

  final bool isNPCChatFinished;
  final String npcChat;

  final bool isUserChatFinished;
  final String userChat;

  final bool isSendEnable;

  final bool isProcessFinished;

  final bool isSubmitLoading;
  final bool isSubmitSucceeded;
  final bool isSubmitFailed;

  TagChatState({
    this.isInitial: false,

    this.isFetchTagsFailed: false,

    this.isIntroChat: false,
    this.isIntroChatBegin: false,
    this.isIntroChatEnd: false,
    this.introChat: '',

    this.isNPCChatFinished: false,
    this.npcChat: '',

    this.isUserChatFinished: false,
    this.userChat: '',

    this.isSendEnable: false,

    this.isProcessFinished: false,

    this.isSubmitLoading: false,
    this.isSubmitSucceeded: false,
    this.isSubmitFailed: false
  });

  factory TagChatState.cleanState() => TagChatState(isSendEnable: true);

  factory TagChatState.initial() => TagChatState(isInitial: true);

  factory TagChatState.fetchTagsFailed() => TagChatState(isFetchTagsFailed: true);

  
  factory TagChatState.introChat(String message, {bool begin: false, bool end: false}) {
    return TagChatState(
      isIntroChat: true,
      introChat: message,
      isIntroChatBegin: begin,
      isIntroChatEnd: end
    );
  }

  factory TagChatState.npcChatFinished(String message) {
    return TagChatState(
      isNPCChatFinished: true,
      npcChat: message
    );
  }

  factory TagChatState.userChatFinished(String message) {
    return TagChatState(
      isUserChatFinished: true,
      userChat: message
    );
  }

  factory TagChatState.processFinished() => TagChatState(isProcessFinished: true);

  factory TagChatState.submitLoading() => TagChatState(isSubmitLoading: true);
  factory TagChatState.submitSucceeded() => TagChatState(isSubmitSucceeded: true);
  factory TagChatState.submitFailed() => TagChatState(isSubmitFailed: true);
}