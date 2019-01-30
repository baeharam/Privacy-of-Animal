import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/tag_select/tag_select.dart';

class TagSelectBloc extends BlocEventStateBase<TagSelectEvent,TagState> {

  int selectedTags = 0;

  @override
    TagState get initialState => TagState.initial();

  @override
  Stream<TagState> eventHandler(TagSelectEvent event, TagState currentState) async*{
    if(event is TagSelectEventActivate){
      if(selectedTags<5){
        selectedTags++;
        yield TagState.activated(event.index);
      }
    }
    if(event is TagSelectEventDeactivate){
      selectedTags--;
      yield TagState.deactivated(event.index);
    }

    if(event is TagSelectEventComplete){
      if(selectedTags==5){
        yield TagState.complete();
      }
    }
  }
}