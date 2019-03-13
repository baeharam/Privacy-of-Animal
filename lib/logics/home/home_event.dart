
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

abstract class HomeEvent extends BlocEvent {}

class HomeEventNavigate extends HomeEvent{
  final int index;

  HomeEventNavigate({
    this.index
  });
}