import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/tag_edit/tag_edit.dart';

class TagEditBloc extends BlocEventStateBase<TagEditEvent,TagEditState> {

  static final TagEditAPI _tagEditAPI = TagEditAPI();

  @override
    TagEditState get initialState => TagEditState.initial();

  @override
  Stream<TagEditState> eventHandler(TagEditEvent event, TagEditState currentState) async*{
    if(event is TagEditEventClick){
      List<String> dropDownItems = _tagEditAPI.filterTags(event.tagIndex);
      yield TagEditState.showDialog(dropDownItems,event.tagIndex);
    }

    if(event is TagEditEventMenuChange){
      yield TagEditState.tagChanged(event.changedTag);
    }
  }
}