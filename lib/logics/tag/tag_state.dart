import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class TagState extends BlocState {
  final bool isTagActivated;
  final bool isTagDeactivated;
  final int tagIndex;
  final bool isTagCompleted;

  TagState({
    this.isTagActivated: false,
    this.isTagDeactivated: true,
    this.tagIndex: 0,
    this.isTagCompleted: false,
  });

  factory TagState.initial() => TagState();

  factory TagState.activated(int index){
    return TagState(
      isTagActivated: true,
      tagIndex: index
    );
  }

  factory TagState.deactivated(int index){
    return TagState(
      isTagDeactivated: true,
      tagIndex: index
    );
  }

  factory TagState.complete(bool isTagCompeted){
    return TagState(
      isTagCompleted: isTagCompeted
    );
  }
}