import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/home/home.dart';

class HomeBloc extends BlocEventStateBase<HomeEvent,HomeState> {

  static final HomeAPI _api = HomeAPI();

  @override
    HomeState get initialState => HomeState.loading(3);

  @override
  Stream<HomeState> eventHandler(HomeEvent event, HomeState currentState) async*{
    if(event is HomeEventNavigate) {
      if(event.index==TAB.MATCH.index){
        yield HomeState.match(event.index);
      }
      else if(event.index==TAB.CHAT.index){
        yield HomeState.chat(event.index);
      }
      else if(event.index==TAB.FRIENDS.index){
        yield HomeState.friend(event.index);
      }
      else if(event.index==TAB.PROFILE.index){
        yield HomeState.loading(event.index);
        try {
          await _api.fetchUserData();
          yield HomeState.profile(event.index);
        } catch(exception) {
          print('사용자 데이터 가져오기 에러: ${exception.toString()}');
          yield HomeState.failed();
        }
      }
    }
  }
}