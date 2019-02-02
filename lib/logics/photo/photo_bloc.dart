import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/photo/photo.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';

class PhotoBloc extends BlocEventStateBase<PhotoEvent,PhotoState>
{
  static final PhotoAPI _api = PhotoAPI();

  @override
  PhotoState get initialState => PhotoState.noTake();

  @override
  Stream<PhotoState> eventHandler(PhotoEvent event, PhotoState currentState) async*{
    
    if (event is PhotoEventTaking) {
      String path = await _api.getImage();
      yield PhotoState.take(path);
    }
    if (event is PhotoEventGotoAnalysis){
      yield PhotoState.loading();
      ANALYZE_RESULT analyzeResult = await _api.analyzeFace(event.photoPath);
      if(analyzeResult == ANALYZE_RESULT.SUCCESS){
        await _api.detectAnimal(sl.get<CurrentUser>().kakaoMLModel);
        yield PhotoState.succeeded();
      }
      else if(analyzeResult == ANALYZE_RESULT.FAILURE){
        yield PhotoState.failed();
      }
    }
  }
}