import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/photo/photo.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';

class PhotoBloc extends BlocEventStateBase<PhotoEvent,PhotoState>
{
  static final PhotoAPI _api = PhotoAPI();

  @override
  PhotoState get initialState => PhotoState.initial();

  @override
  Stream<PhotoState> eventHandler(PhotoEvent event, PhotoState currentState) async*{

    if(event is PhotoEventStateClear) {
      yield PhotoState.initial();
    }

    if(event is PhotoEventEmitLoading){
      yield PhotoState.loading(event.percentage);
    }

    if (event is PhotoEventFetching) {
      String path = await _api.getImageFromGallery();
      yield PhotoState.take(path);
    }
    
    if (event is PhotoEventTaking) {
      String path = await _api.getImageFromCamera();
      yield PhotoState.take(path);
    }

    if (event is PhotoEventGotoAnalysis){
      yield PhotoState.loading(0.0);
      await _api.analyzeFaceKakao(event.photoPath);
      try {
         await _api.analyzeFaceKakao(event.photoPath);
         try {
            await _api.analyzeFaceNaver(event.photoPath);
            try {
              await _api.analyzeCelebrityNaver(event.photoPath);
              await _api.detectAnimal(sl.get<CurrentUser>().kakaoMLModel);
              try {
                await _api.storeProfile();
                try {
                  yield PhotoState.loading(1.0);
                  await _api.setFlags();
                  yield PhotoState.succeeded();
                } catch(exception) {
                  print('설정 초기화 실패 ${exception.toString()}');
                  yield PhotoState.failed();
                }
              } catch(exception) {
                print('프로필 저장 실패 ${exception.toString()}');
                yield PhotoState.failed();
              }
            } catch(exception) {
              print('네이버 유명인인식 실패 ${exception.toString()}');
              yield PhotoState.failed();
            }
         } catch(exception) {
            print('네이버 얼굴분석실패 ${exception.toString()}');
            yield PhotoState.failed();
         }
      } catch(exception) {
        print('카카오 얼굴분석실패 ${exception.toString()}');
        yield PhotoState.failed();
      }
    }
  }
}