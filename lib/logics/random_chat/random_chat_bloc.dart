import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/random_chat/random_chat.dart';

class RandomChatBloc extends BlocEventStateBase<RandomChatEvent,RandomChatState>
{
  static final RandomChatAPI api = RandomChatAPI();

  @override
  RandomChatState get initialState => RandomChatState.loading();

  @override
  Stream<RandomChatState> eventHandler(RandomChatEvent event, RandomChatState currentState) async*{
    if(event is RandomChatEventMatchStart){
      await api.setRandomUser();
      yield RandomChatState.loading();
      String opponent = await api.findUser();
      yield RandomChatState.matchSucceeded();
      await api.updateUsers(opponent);
    }
    if(event is RandomChatEventMatchUsers){
      await api.updateUsers(event.user);
    }
    if(event is RandomChatEventCancel){
      yield RandomChatState.cancel();
      await api.deleteUser();
    }
  }
}