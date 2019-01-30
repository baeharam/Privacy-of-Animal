import 'package:meta/meta.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

abstract class TagEvent extends BlocEvent{}

class TagEventImageLoad extends TagEvent {}

class TagEventSelectActivate extends TagEvent {
  final int index;
  TagEventSelectActivate({
    @required this.index
  });
}

class TagEventSelectDeactivate extends TagEvent {
  final int index;
  TagEventSelectDeactivate({
    @required this.index
  });
}

class TagEventComplete extends TagEvent {
  
}