import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class TagChatState extends BlocState {

  final bool isNPC;
  final String messageNPC;
  final bool isBegin;
  final bool isInitial;

  final bool isUser;
  final String messageUser;

  final bool isNPCDone;
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
    this.showSubmitButton: false,
    this.isDetailStoreLoading: false,
    this.isDetailStoreSucceeded: false,
    this.isDetailStoreFailed: false
  });

  factory TagChatState.npcMessage({String message, bool isBegin, bool isInitial, bool isNPCDone}) {
    return TagChatState(
      isNPC: true,
      messageNPC: message??'',
      isBegin: isBegin??false,
      isInitial: isInitial??false,
      isNPCDone: isNPCDone??false,
    );
  }

  factory TagChatState.userMessage(String message) {
    return TagChatState(
      isUser: true,
      messageUser: message
    );
  }

  factory TagChatState.nothing(bool isNPCDone) {
    return TagChatState(
      isNPCDone: isNPCDone
    );
  }

  factory TagChatState.showButton() {
    return TagChatState(
      showSubmitButton: true
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
      isDetailStoreFailed: true,
      showSubmitButton: true
    );
  }
}