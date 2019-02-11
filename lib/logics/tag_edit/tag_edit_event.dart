import 'package:meta/meta.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

abstract class TagEditEvent extends BlocEvent{}

class TagEventInitial extends TagEditEvent {}

class TagEditEventClick extends TagEditEvent {
  final int tagIndex;
  TagEditEventClick({@required this.tagIndex});
}

class TagEditEventMenuChange extends TagEditEvent {
  final String changedTag;
  TagEditEventMenuChange({@required this.changedTag});
}

class TagEditEventSubmit extends TagEditEvent {
  final String tagTitle;
  final String tagDetail;
  final int tagIndex;

  TagEditEventSubmit({
    @required this.tagTitle,
    @required this.tagDetail,
    @required this.tagIndex
  });
}