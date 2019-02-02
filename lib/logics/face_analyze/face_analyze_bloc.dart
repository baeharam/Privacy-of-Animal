import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/face_analyze/face_analyze.dart';


class FaceAnalyzeBloc extends BlocEventStateBase<FaceAnalyzeEvent,FaceAnalyzeState>
{

  @override
  FaceAnalyzeState get initialState => FaceAnalyzeState.undo();
  
  @override
  Stream<FaceAnalyzeState> eventHandler(FaceAnalyzeEvent event, FaceAnalyzeState currentstate) async*{
    if (event is FaceAnalyzeEventUnAnaylze){
      //naver api 사용하여 분석하기
      yield FaceAnalyzeState.doing();
    }
    if (event is FaceAnalyzeEventAnaylzeDone){
      // 분석한 결과 화면에 보여주기
      yield FaceAnalyzeState.done();
    }

    if (event is FaceAnalyzeEventClickGotoButton){
      // 프로필 화면으로 이동하기
      yield FaceAnalyzeState.gotoProfile();
    }
  }
}