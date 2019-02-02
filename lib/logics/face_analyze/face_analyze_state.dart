import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class FaceAnalyzeState extends BlocState {
  final bool doingAnalyze;
  final bool doneAnalyze;
  final bool gotoMyProfile;

  FaceAnalyzeState({
    this.doingAnalyze = false,
    this.doneAnalyze = false,
    this.gotoMyProfile = false
  });

  factory FaceAnalyzeState.undo() {
    return FaceAnalyzeState(
      doingAnalyze: false,
      doneAnalyze: false,
      gotoMyProfile: false
    );
  }

  factory FaceAnalyzeState.doing(){
    return FaceAnalyzeState(
      doingAnalyze: true
    );
  }

  factory FaceAnalyzeState.done() {
    return FaceAnalyzeState(
      doneAnalyze: true,
      doingAnalyze: false
    );
  }
  factory FaceAnalyzeState.gotoProfile() {
    return FaceAnalyzeState(
      gotoMyProfile: true
    );
  }
}

