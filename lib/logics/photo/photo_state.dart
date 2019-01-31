import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'dart:io';

class PhotoState extends BlocState {
  final bool takedPhoto;
  final bool gotoAnalysis;
  String path;
  
  PhotoState({
    this.takedPhoto = false,
    this.gotoAnalysis = false,
    this.path
  });

  factory PhotoState.noTake() {
    return PhotoState(
    takedPhoto : false,
    gotoAnalysis : false,
    );
  }
  
  factory PhotoState.take(String  path) {
    return PhotoState(
      takedPhoto:true,
      path: path
    );
  }

  factory PhotoState.analysis(){
    return PhotoState(
      gotoAnalysis: true
    );
  }
}