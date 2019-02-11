import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class TagEditState extends BlocState {
  final bool isSucceeded;
  final bool isFailed;
  final bool isLoading;
  final bool isShowDialog;
  final bool isTagChanged;
  final List<String> dropDownItems;
  final int tagIndex;
  final String currentTag;

  TagEditState({
    this.isSucceeded: false,
    this.isFailed: false,
    this.isLoading: false,
    this.isShowDialog: false,
    this.isTagChanged: false,
    this.dropDownItems: const [],
    this.tagIndex: 0,
    this.currentTag: ''
  });

  factory TagEditState.showDialog(List<String> dropDownItems, int tagIndex) {
    return TagEditState(
      isShowDialog: true,
      dropDownItems: dropDownItems,
      tagIndex: tagIndex
    );
  }

  factory TagEditState.tagChanged(String currentTag) {
    return TagEditState(
      isTagChanged: true,
      currentTag: currentTag
    );
  }

  factory TagEditState.initial() {
    return TagEditState();
  }

  factory TagEditState.loading() {
    return TagEditState(
      isLoading: true
    );
  }

  factory TagEditState.succeeded() {
    return TagEditState(
      isSucceeded: true
    );
  }

  factory TagEditState.failed() {
    return TagEditState(
      isFailed: true
    );
  }
}