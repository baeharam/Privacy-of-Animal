import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/tag_chat/tag_chat.dart';
import 'package:privacy_of_animal/resources/resources.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';

class TagChatBloc extends BlocEventStateBase<TagChatEvent,TagChatState> {

  final TagChatAPI _tagChatAPI = TagChatAPI();
  static const int _chatDuration = 1000;
  int order = 0;

  @override
    TagChatState get initialState => TagChatState.npcMessage(tagChatNPCIntro[0],true,true);

  @override
  Stream<TagChatState> eventHandler(TagChatEvent event, TagChatState currentState) async*{
    if(event is TagChatEventDone){
      order = sl.get<CurrentUser>().tagListModel.tagDetailList.length;
      if(order<5){
        yield TagChatState.done(event.isNPCDone,event.isUserDone,false);
      } else if(order==5){
        yield TagChatState.done(event.isNPCDone,event.isUserDone,true);
      }
    }
    if(event is TagChatEventNPC){
      if(event.isInitial){
        await Future.delayed(const Duration(milliseconds: _chatDuration));
        yield TagChatState.npcMessage(tagChatNPCIntro[1],false,false);
        await Future.delayed(const Duration(milliseconds: _chatDuration));
        yield TagChatState.npcMessage(tagChatNPCIntro[2],false,false);
        TAG_CHECK_RESULT checkResult = await _tagChatAPI.checkLoaclDB();
        if(checkResult==TAG_CHECK_RESULT.SUCCESS){
          await Future.delayed(const Duration(milliseconds: _chatDuration));
          yield TagChatState.npcMessage(tagToMessage[sl.get<CurrentUser>().tagListModel.tagTitleList[order]],false,false);
        } else if(checkResult == TAG_CHECK_RESULT.FAILURE){
          yield TagChatState.failed();
        }
      }
      else{
        order = sl.get<CurrentUser>().tagListModel.tagDetailList.length;
        if(order<5){
          await Future.delayed(const Duration(milliseconds: _chatDuration));
          yield TagChatState.npcMessage(tagToMessage[sl.get<CurrentUser>().tagListModel.tagTitleList[order]],true,false);
        }
      }
    }
    if(event is TagChatEventUser){
      sl.get<CurrentUser>().tagListModel.tagDetailList.add(event.message);
      yield TagChatState.userMessage(event.message);
    }
  }
}