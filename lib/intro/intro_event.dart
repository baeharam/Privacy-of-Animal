
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

abstract class IntroEvent extends BlocEvent {}

class IntroEventSlide extends IntroEvent {
  final int indexOfScreen;

  IntroEventSlide({this.indexOfScreen});
}

class IntroEventLoginButtonClick extends IntroEvent {}
class IntroEventSignUPButtonClick extends IntroEvent {}