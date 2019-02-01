import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class TagChatState extends BlocState {

  final bool isNPC;
  final String messageNPC;
  final bool isBegin;
  final bool isInitial;

  final bool isUser;
  final String messageUser;

  final bool isNPCDone;
  final bool isUserDone;
  final bool showSubmitButton;

  final bool isDetailStoreLoading;
  final bool isDetailStoreSucceeded;
  final bool isDetailStoreFailed;

  TagChatState({
    this.isNPC: false,
    this.messageNPC: '',
    this.isBegin: false,
    this.isInitial: false,
    this.isUser: false,
    this.messageUser: '',
    this.isNPCDone: false,
    this.isUserDone: false,
    this.showSubmitButton: false,
    this.isDetailStoreLoading: false,
    this.isDetailStoreSucceeded: false,
    this.isDetailStoreFailed: false
  });

  factory TagChatState.done(bool isNPCDone, bool isUserDone, bool showSubmitButton) {
    return TagChatState(
      isNPCDone: isNPCDone,
      isUserDone: isUserDone,
      showSubmitButton: showSubmitButton ?? false
    );
  }

  factory TagChatState.npcMessage(String message, bool isBegin, bool isInitial) {
    return TagChatState(
      isNPC: true,
      messageNPC: message,
      isBegin: isBegin,
      isInitial: isInitial
    );
  }

  factory TagChatState.userMessage(String message) {
    return TagChatState(
      isUser: true,
      messageUser: message
    );
  }

  factory TagChatState.loading() {
    return TagChatState(
      isDetailStoreLoading: true
    );
  }

  factory TagChatState.succeeded() {
    return TagChatState(
      isDetailStoreSucceeded: true
    );
  }

  factory TagChatState.failed() {
    return TagChatState(
      isDetailStoreFailed: true
    );
  }
}