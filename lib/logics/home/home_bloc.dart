import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/home/home.dart';

class HomeBloc extends BlocEventStateBase<HomeEvent,HomeState> {

  static final HomeAPI _api = HomeAPI();

  @override
    HomeState get initialState => HomeState.fetchLoading();

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
        yield HomeState.profile(event.index);
      }
    }
    
    if(event is HomeEventFetchAll) {
      yield HomeState.fetchLoading();
      try {
        await _api.fetchProfileData();
        await _api.fetchFriendsData();
        await _api.fetchChatData();
        yield HomeState.fetchSucceeded();
      } catch(exception) {
        print("데이터 가져오기 에러: ${exception.toString()}");
        yield HomeState.fetchFailed();
      }
    }

    if(event is HomeEventDeactivateFlags) {
      _api.deactivateFlags();
    }
  }
}