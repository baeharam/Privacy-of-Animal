import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/tag_select/tag_select.dart';

class TagSelectBloc extends BlocEventStateBase<TagSelectEvent,TagSelectState> {

  final TagSelectAPI _tagSelectAPI = TagSelectAPI();
  int selectedTags = 0;

  @override
    TagSelectState get initialState => TagSelectState.initial();

  @override
  Stream<TagSelectState> eventHandler(TagSelectEvent event, TagSelectState currentState) async*{
    if(event is TagSelectEventActivate){
      if(selectedTags<5){
        selectedTags++;
        yield TagSelectState.activated(event.index);
      }
    }
    if(event is TagSelectEventDeactivate){
      selectedTags--;
      yield TagSelectState.deactivated(event.index);
    }

    if(event is TagSelectEventComplete){
      if(selectedTags==5){
        TAG_STORE_RESULT result = await _tagSelectAPI.storeTags(event.isTagSelected);
        if(result==TAG_STORE_RESULT.SUCCESS){
          yield TagSelectState.complete();
        }
      }
    }
  }
}