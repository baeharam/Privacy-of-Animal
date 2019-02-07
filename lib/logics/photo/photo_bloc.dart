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
      ANALYZE_RESULT analyzeResultKakao = await _api.analyzeFaceKakao(event.photoPath);
      ANALYZE_RESULT analyzeResultNaver = await _api.analyzeFaceNaver(event.photoPath);
      await _api.detectAnimal(sl.get<CurrentUser>().kakaoMLModel);
      ANALYZE_RESULT analyzeResultFlag = await _api.storeProfile();
      if(analyzeResultKakao == ANALYZE_RESULT.SUCCESS 
        && analyzeResultNaver == ANALYZE_RESULT.SUCCESS
        && analyzeResultFlag == ANALYZE_RESULT.SUCCESS){
        yield PhotoState.succeeded();
      }
      else {
        yield PhotoState.failed();
      }
    }
  }
}