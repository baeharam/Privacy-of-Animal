import 'package:meta/meta.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

abstract class TagSelectEvent extends BlocEvent{}

class TagSelectEventActivate extends TagSelectEvent {
  final int index;
  TagSelectEventActivate({
    @required this.index
  });
}

class TagSelectEventDeactivate extends TagSelectEvent {
  final int index;
  TagSelectEventDeactivate({
    @required this.index
  });
}

class TagSelectEventComplete extends TagSelectEvent {
  final List<bool> isTagSelected;
  TagSelectEventComplete({
    @required this.isTagSelected
  });
}