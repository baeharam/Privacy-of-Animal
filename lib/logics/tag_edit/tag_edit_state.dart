import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class TagEditState extends BlocState {
  final bool isSucceeded;
  final bool isFailed;
  final bool isLoading;

  TagEditState({
    this.isSucceeded: false,
    this.isFailed: false,
    this.isLoading: false
  });

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