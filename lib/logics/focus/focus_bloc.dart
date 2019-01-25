import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/focus/focus.dart';

class FocusBloc extends BlocEventStateBase<FocusEvent, FocusState> {

  @override
    FocusState get initialState => FocusState.unFocused();

  @override
  Stream<FocusState> eventHandler(FocusEvent event, FocusState currentState) async*{
    
    if(event is FocusEventOn){
      yield FocusState.focused();
    }
    if(event is FocusEventOff){
      yield FocusState.unFocused();
    }
  }
}