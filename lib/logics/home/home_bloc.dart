import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/home/home.dart';

class HomeBloc extends BlocEventStateBase<HomeEvent,HomeState> {

  @override
    HomeState get initialState => HomeState.profile(3);

  @override
  Stream<HomeState> eventHandler(HomeEvent event, HomeState currentState) async*{
    if(event.index==0){
      yield HomeState.match(event.index);
    }
    else if(event.index==1){
      yield HomeState.chat(event.index);
    }
    else if(event.index==2){
      yield HomeState.friend(event.index);
    }
    else if(event.index==3){
      yield HomeState.profile(event.index);
    }
  }
}