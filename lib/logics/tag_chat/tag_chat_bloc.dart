import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/tag_chat/tag_chat.dart';
import 'package:privacy_of_animal/resources/resources.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';

class TagChatBloc extends BlocEventStateBase<TagChatEvent,TagChatState> {

  static TagChatAPI _api = TagChatAPI();

  @override
    TagChatState get initialState => TagChatState.initial();

  @override
  Stream<TagChatState> eventHandler(TagChatEvent event, TagChatState currentState) async*{

    if(event is TagChatEventStateClear) {
      yield TagChatState.cleanState();
    }

    // 처음 채팅 시작
    if(event is TagChatEventBeginChat) {
      try {
        await _api.checkLoaclDBandFetch();
        yield TagChatState.introChat(tagChatNPCIntro[0],begin: true);
        await Future.delayed(const Duration(milliseconds: TagChatAPI.introDelayTime));
        yield TagChatState.introChat(tagChatNPCIntro[1]);
        await Future.delayed(const Duration(milliseconds: TagChatAPI.introDelayTime));
        yield TagChatState.introChat(tagChatNPCIntro[2],end: true);
        await Future.delayed(const Duration(milliseconds: TagChatAPI.introDelayTime));
        yield TagChatState.introChat(
          tagToMessage[sl.get<CurrentUser>().tagListModel.tagTitleList[_api.npcChatListIndex++]],
          end: true
        );
      } catch(exception) {
        print('태그정보 가져오기 실패: ${exception.toString()}');
        yield TagChatState.fetchTagsFailed();
      }
    }

    if(event is TagChatEventUserChat) {
      if(_api.npcChatListIndex<5) {
        yield TagChatState.userChatFinished(event.message);
        await Future.delayed(const Duration(milliseconds: TagChatAPI.chatDelayTime));
        yield TagChatState.npcChatFinished(
          tagToMessage[sl.get<CurrentUser>().tagListModel.tagTitleList[_api.npcChatListIndex++]]);
      } else {
        yield TagChatState.userChatFinished(event.message,end: true);
      }
      _api.saveUserAnswer(event.message);
    }

    if(event is TagChatEventComplete) {
      try {
        yield TagChatState.submitLoading();
        await _api.storeTagDetail();
        yield TagChatState.submitSucceeded();
      } catch(exception) {
        print('태그 상세정보 저장 실패: ${exception.toString()}');
        yield TagChatState.submitFailed();
      }
    }
  }
}