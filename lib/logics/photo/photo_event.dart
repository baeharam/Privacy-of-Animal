import 'package:meta/meta.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

abstract class PhotoEvent extends BlocEvent{}

class PhotoEventReset extends PhotoEvent {}

class PhotoEventTaking extends PhotoEvent {}

class PhotoEventGotoAnalysis extends PhotoEvent {
  final String photoPath;

  PhotoEventGotoAnalysis({
    @required this.photoPath
  });
}