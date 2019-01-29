import 'package:meta/meta.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

abstract class TagEvent extends BlocEvent{}

class TagEventImageLoad extends TagEvent {}

class TagEventSelect extends TagEvent {
  final int index;
  TagEventSelect({
    @required this.index
  });
}

class TagEventComplete extends TagEvent {
  
}