import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/tag_edit/tag_edit.dart';

class TagEditBloc extends BlocEventStateBase<TagEditEvent,TagEditState> {

  @override
    TagEditState get initialState => TagEditState.initial();

  @override
  Stream<TagEditState> eventHandler(TagEditEvent event, TagEditState currentState) async*{
    if(event is TagEditEventClick){
      yield TagEditState.loading();
      
    }
  }
}