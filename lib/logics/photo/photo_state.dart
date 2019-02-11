import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class PhotoState extends BlocState {
  final bool isPhotoDone;
  final bool isAnalyzeSucceeded;
  final bool isAnalyzeFailed;
  final bool isLoading;
  final double percentage;
  final String path;
  
  PhotoState({
    this.isPhotoDone: false,
    this.isAnalyzeSucceeded: false,
    this.isAnalyzeFailed: false,
    this.isLoading: false,
    this.percentage: 0.0,
    this.path: '',
  });

  factory PhotoState.noTake() {
    return PhotoState(
    isPhotoDone : false,
    isAnalyzeSucceeded : false,
    );
  }
  
  factory PhotoState.take(String path) {
    return PhotoState(
      isPhotoDone:true,
      path: path
    );
  }

  factory PhotoState.loading(double percentage){
    return PhotoState(
      isLoading: true,
      percentage: percentage
    );
  }

  factory PhotoState.succeeded(){
    return PhotoState(
      isAnalyzeSucceeded: true,
    );
  }

  factory PhotoState.failed(){
    return PhotoState(
      isAnalyzeFailed: true,
    );
  }
}