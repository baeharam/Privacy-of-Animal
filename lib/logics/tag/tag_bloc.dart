import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/tag/tag.dart';

class TagBloc extends BlocEventStateBase<TagEvent,TagState> {

  int selectedTags = 0;

  @override
    TagState get initialState => TagState.initial();

  @override
  Stream<TagState> eventHandler(TagEvent event, TagState currentState) async*{
    if(event is TagEventSelectActivate){
      if(selectedTags<5){
        selectedTags++;
        yield TagState.activated(event.index);
      }
    }
    if(event is TagEventSelectDeactivate){
      selectedTags--;
      yield TagState.deactivated(event.index);
    }

    if(event is TagEventComplete){
      if(selectedTags==5){
        yield TagState.complete();
      }
    }
  }
}