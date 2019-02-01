import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/tag_chat/tag_chat.dart';
import 'package:privacy_of_animal/resources/resources.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';

class TagChatBloc extends BlocEventStateBase<TagChatEvent,TagChatState> {

  final TagChatAPI _tagChatAPI = TagChatAPI();
  static const int _chatDuration = 1000;
  static const int _maxTagNum = 5;
  int order = 0;

  @override
    TagChatState get initialState => TagChatState.npcMessage(tagChatNPCIntro[0],true,true);

  @override
  Stream<TagChatState> eventHandler(TagChatEvent event, TagChatState currentState) async*{
    // NPC나 사용자가 채팅을 보내고 나서 끝났다는 플래그
    if(event is TagChatEventDone){
      order = sl.get<CurrentUser>().tagListModel.tagDetailList.length;
      if(order<_maxTagNum){
        yield TagChatState.done(event.isNPCDone,event.isUserDone,false);
      } else if(order==_maxTagNum){
        yield TagChatState.done(event.isNPCDone,event.isUserDone,true);
      }
    }

    // NPC가 채팅을 보낸 경우
    if(event is TagChatEventNPC){
      // 제일 처음인 경우, 일정 시간간격을 두고 보내야함.
      if(event.isInitial){
        await Future.delayed(const Duration(milliseconds: _chatDuration));
        yield TagChatState.npcMessage(tagChatNPCIntro[1],false,false);
        await Future.delayed(const Duration(milliseconds: _chatDuration));
        yield TagChatState.npcMessage(tagChatNPCIntro[2],false,false);

        // 처음 인트로 메시지 3개 보내면 DB체크해서 태그 5가지 데이터 가져오기
        TAG_CHECK_RESULT checkResult = await _tagChatAPI.checkLoaclDB();

        if(checkResult==TAG_CHECK_RESULT.SUCCESS){
          await Future.delayed(const Duration(milliseconds: _chatDuration));
          yield TagChatState.npcMessage(tagToMessage[sl.get<CurrentUser>().tagListModel.tagTitleList[order]],false,false);
        } else if(checkResult == TAG_CHECK_RESULT.FAILURE){
          yield TagChatState.failed();
        }
      }
      // 제일 처음이 아닌 경우는 그냥 보내도 된다.
      else{
        order = sl.get<CurrentUser>().tagListModel.tagDetailList.length;
        if(order<5){
          await Future.delayed(const Duration(milliseconds: _chatDuration-500));
          yield TagChatState.npcMessage(tagToMessage[sl.get<CurrentUser>().tagListModel.tagTitleList[order]],true,false);
        }
      }
    }

    // 사용자가 채팅을 보낸 경우
    if(event is TagChatEventUser){
      sl.get<CurrentUser>().tagListModel.tagDetailList.add(event.message);
      yield TagChatState.userMessage(event.message);
    }

    // 완료 버튼을 누른 경우
    if(event is TagChatEventComplete){
      yield TagChatState.loading();
      TAG_DETAIL_STORE_RESULT storeResult = await _tagChatAPI.storeTagDetail();
      if(storeResult == TAG_DETAIL_STORE_RESULT.FAILURE){
        yield TagChatState.failed();
      } else if(storeResult == TAG_DETAIL_STORE_RESULT.SUCCESS){
        yield TagChatState.succeeded();
      }
    }
  }
}