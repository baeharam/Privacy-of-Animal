import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class FaceAnalyzeEvent extends BlocEvent {}

class FaceAnalyzeEventUnAnaylze extends FaceAnalyzeEvent {}

class FaceAnalyzeEventAnaylzeDone extends FaceAnalyzeEvent {}

class FaceAnalyzeEventClickGotoButton extends FaceAnalyzeEvent {}