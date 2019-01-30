import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class TagSelectState extends BlocState {
  final bool isInitial;
  final bool isTagActivated;
  final bool isTagDeactivated;
  final int tagIndex;
  final bool isTagCompleted;
  final bool isTagFailed;
  final bool isTagLoading;

  TagSelectState({
    this.isInitial: false,
    this.isTagActivated: false,
    this.isTagDeactivated: true,
    this.tagIndex: 0,
    this.isTagCompleted: false,
    this.isTagFailed: false,
    this.isTagLoading: false,
  });

  factory TagSelectState.initial() => TagSelectState(isInitial: true);

  factory TagSelectState.activated(int index){
    return TagSelectState(
      isTagActivated: true,
      tagIndex: index
    );
  }

  factory TagSelectState.deactivated(int index){
    return TagSelectState(
      isTagDeactivated: true,
      tagIndex: index
    );
  }

  factory TagSelectState.complete(){
    return TagSelectState(
      isTagCompleted: true
    );
  }

  factory TagSelectState.failed(){
    return TagSelectState(
      isTagFailed: true
    );
  }

  factory TagSelectState.loading(){
    return TagSelectState(
      isTagLoading: true
    );
  }
}