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

    if(event is PhotoEventReset) {
      yield PhotoState.noTake();
    }
    
    if (event is PhotoEventTaking) {
      String path = await _api.getImage();
      yield PhotoState.take(path);
    }
    if (event is PhotoEventGotoAnalysis){
      yield PhotoState.loading(0.0);
      ANALYZE_RESULT analyzeResultKakao = await _api.analyzeFaceKakao(event.photoPath);
      if(analyzeResultKakao==ANALYZE_RESULT.FAILURE){
        yield PhotoState.failed();
      }else{
        yield PhotoState.loading(0.33);
        ANALYZE_RESULT analyzeResultNaver = await _api.analyzeFaceNaver(event.photoPath);
        analyzeResultNaver = await _api.analyzeCelebrityNaver(event.photoPath);
        GET_IMAGE_RESULT getImageResult = await _api.getImageFromInternet();
        if(analyzeResultNaver==ANALYZE_RESULT.FAILURE || getImageResult==GET_IMAGE_RESULT.FAILURE){
          yield PhotoState.failed();
        }else{
          yield PhotoState.loading(0.66);
          await _api.detectAnimal(sl.get<CurrentUser>().kakaoMLModel);
          ANALYZE_RESULT storeResult = await _api.storeProfile();
          if(storeResult==ANALYZE_RESULT.FAILURE){
            yield PhotoState.failed();
          }else{
            await _api.setFlags();
            yield PhotoState.loading(1.0);
            yield PhotoState.succeeded();
          }
        }
      }
    }
  }
}