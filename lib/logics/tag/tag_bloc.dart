import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/tag/tag.dart';
import 'package:privacy_of_animal/resources/constants.dart';
import 'package:privacy_of_animal/utils/image_compresser.dart';

class TagBloc extends BlocEventStateBase<TagEvent,TagState> {

  static final TagAPI _api = TagAPI();

  @override
    TagState get initialState => TagState.initial();

  @override
  Stream<TagState> eventHandler(TagEvent event, TagState currentState) async*{
    if(event is TagEventSelect){
      yield TagState.selected(event.index);
    }

    if(event is TagEventImageLoad){
      for(int i=0; i<tags.length; i++){
        List<int> compressedImage = await compressImage(tags[i].image);
        yield TagState.imageLoaded(compressedImage,i);
      }
    }
  }
}