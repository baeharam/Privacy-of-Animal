import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/random_chat/random_chat.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';

class RandomChatBloc extends BlocEventStateBase<RandomChatEvent,RandomChatState>
{
  static final RandomChatAPI api = RandomChatAPI();

  @override
  RandomChatState get initialState => RandomChatState.loading();

  @override
  Stream<RandomChatState> eventHandler(RandomChatEvent event, RandomChatState currentState) async*{
    if(event is RandomChatEventMatchStart){
      await api.setRandomUser();
    }
    if(event is RandomChatEventMatchUsers){
      await api.updateUsers(event.userMyself, event.userOpponent);
    }
  }
}