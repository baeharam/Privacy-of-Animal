import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class PhotoState extends BlocState {
  final bool takedPhoto;
  final bool isImageLoaded;
  final bool retakePhoto;
  final bool gotoAnalysis;
  String path;
  
  PhotoState({
    this.takedPhoto = false,
    this.isImageLoaded = false,
    this.retakePhoto = false,
    this.gotoAnalysis = false,
    this.path =""
  });

  factory PhotoState.noTake() {
    return PhotoState(
    takedPhoto : false,
    isImageLoaded : false,
    retakePhoto : false,
    gotoAnalysis : false,
    );
  }
  
  factory PhotoState.take(String  path) {
    return PhotoState(
      takedPhoto:true,
      path: path
    );
  }

  factory PhotoState.isLoaded(String path){
    return PhotoState(
      isImageLoaded: true,
      path: path
      );
  }
  factory PhotoState.retake(String path){
    return PhotoState(
      retakePhoto: true,
      path: path
      );
  }
  factory PhotoState.analysis(){
    return PhotoState(
      gotoAnalysis: true
    );
  }
}