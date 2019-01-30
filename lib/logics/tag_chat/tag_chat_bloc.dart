import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/tag_chat/tag_chat.dart';

class TagChatBloc extends BlocEventStateBase<TagChatEvent,TagChatState> {

  @override
    TagChatState get initialState => TagChatState.initial(1);

  @override
  Stream<TagChatState> eventHandler(TagChatEvent event, TagChatState currentState) async*{
    if(event is TagChatEventBegin){
      yield TagChatState.initial(2);
      await Future.delayed(const Duration(milliseconds: 2000));
      yield TagChatState.initial(3);
      await Future.delayed(const Duration(milliseconds: 2000));
      yield TagChatState.initial(4);
    }
    if(event is TagChatEventChat1){
      yield TagChatState.chatFinished(1,event.message);
    }
    if(event is TagChatEventChat2){
      yield TagChatState.chatFinished(2,event.message);
    }
    if(event is TagChatEventChat3){
      yield TagChatState.chatFinished(3,event.message);
    }
    if(event is TagChatEventChat4){
      yield TagChatState.chatFinished(4,event.message);
    }
    if(event is TagChatEventChat5){
      yield TagChatState.chatFinished(5,event.message);
    }
  }
}