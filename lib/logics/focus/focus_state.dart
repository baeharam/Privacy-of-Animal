import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class FocusState extends BlocState {
  final bool isFocused;

  FocusState({this.isFocused});

  factory FocusState.focused() => FocusState(isFocused: true);
  factory FocusState.unFocused() => FocusState(isFocused: false);
}