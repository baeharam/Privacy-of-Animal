import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class TagChatState extends BlocState {
  final bool isInitial;
  final int initialOrder;

  final bool isChatFinished;
  final int chatOrder;
  final String tagDetail;

  final bool isDetailStoreLoading;
  final bool isDetailStoreSucceeded;
  final bool isDetailStoreFailed;

  TagChatState({
    this.isInitial: false,
    this.initialOrder: 0,
    this.isChatFinished: false,
    this.chatOrder: 0,
    this.tagDetail:'',
    this.isDetailStoreLoading: false,
    this.isDetailStoreSucceeded: false,
    this.isDetailStoreFailed: false
  });

  factory TagChatState.initial(int order) {
    return TagChatState(
      isInitial: true,
      initialOrder: order
    );
  }

  factory TagChatState.chatFinished(int order, String detail) {
    return TagChatState(
      isChatFinished: true,
      chatOrder: order,
      tagDetail: detail
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