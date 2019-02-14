import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/home/home.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';

class HomeBloc extends BlocEventStateBase<HomeEvent,HomeState> {

  final HomeAPI _api = HomeAPI();

  @override
    HomeState get initialState => HomeState.loading(3);

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
      if(sl.get<CurrentUser>().isDataFetched==false){
        FETCH_RESULT result = await _api.fetchUserData();
        if(result == FETCH_RESULT.SUCCESS){
          yield HomeState.profile(event.index);
        }
      }
      else {
        yield HomeState.profile(event.index);
      }
    }
  }
}