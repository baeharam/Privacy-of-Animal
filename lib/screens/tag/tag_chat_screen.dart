import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_helpers.dart';
import 'package:privacy_of_animal/logics/tag_chat/tag_chat.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/screens/tag/tag_chat_input.dart';
import 'package:privacy_of_animal/screens/tag/tag_chat_npc.dart';
import 'package:privacy_of_animal/screens/tag/tag_chat_user.dart';
import 'package:privacy_of_animal/utils/back_button_dialog.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/utils/bloc_navigator.dart';
import 'package:privacy_of_animal/utils/bloc_snackbar.dart';
import 'package:privacy_of_animal/widgets/primary_button.dart';
import 'package:privacy_of_animal/widgets/progress_indicator.dart';

class TagChatScreen extends StatefulWidget {
  @override
  _TagChatScreenState createState() => _TagChatScreenState();
}

class _TagChatScreenState extends State<TagChatScreen> {

  static const int maxChatNum = 13;
  final TagChatBloc _tagChatBloc = sl.get<TagChatBloc>();
  final ScrollController _scrollController = ScrollController();
  List<Widget> chatWidgets = [];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // 채팅이 입력될 때마다 스크롤이 내려가는 원리
  void _moveScroll(int index) {
    if(index==chatWidgets.length-1 && _scrollController.position.maxScrollExtent!=null){
      WidgetsBinding.instance.addPostFrameCallback((_){
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: WillPopScope(
        onWillPop: () => BackButtonAction.stopInMiddle(context),
        child: BlocBuilder(
          bloc: _tagChatBloc,
          builder: (context, TagChatState state){
            if(state.isInitial) {
              _tagChatBloc.emitEvent(TagChatEventBeginChat());
            }
            if(state.isIntroChat) {
              chatWidgets.add(TagChatNPC(isBegin: state.isIntroChatBegin, message: state.introChat));
              if(state.isIntroChatEnd) {
                _tagChatBloc.emitEvent(TagChatEventStateClear());
              }
            }
            if(state.isNPCChatFinished) {
              chatWidgets.add(TagChatNPC(isBegin: true, message: state.npcChat));
              _tagChatBloc.emitEvent(TagChatEventStateClear());
            }
            if(state.isUserChatFinished && chatWidgets.length<maxChatNum) {
              chatWidgets.add(TagChatUser(message: state.userChat));
              if(!state.isProcessFinished) {
                _tagChatBloc.emitEvent(TagChatEventStateClear());
              }
            }
            if(state.isSubmitSucceeded) {
              BlocNavigator.pushReplacementNamed(context, routePhotoDecision);
            }
            if(state.isSubmitFailed) {
              BlocSnackbar.show(context, '제출에 실패했습니다.');
              _tagChatBloc.emitEvent(TagChatEventStateClear());
            }
            if(state.isFetchTagsFailed) {
              BlocSnackbar.show(context, '태그정보를 가져오는데 실패했습니다.');
              _tagChatBloc.emitEvent(TagChatEventStateClear());
            }

            return Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 30.0),
                    itemCount: chatWidgets.length,
                    itemBuilder: (context,index) {
                      _moveScroll(index);
                      return chatWidgets[index];
                    },
                    controller: _scrollController,
                  ),
                ),  
                state.isProcessFinished || state.isSubmitFailed 
                ? Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: PrimaryButton(
                    color: primaryBeige,
                    text: '제출 하기',
                    callback: ()=>_tagChatBloc.emitEvent(TagChatEventComplete())
                  )
                )
                : (state.isSubmitLoading || state.isSubmitSucceeded
                  ? Padding(  
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: CustomProgressIndicator()
                    )
                  : TagChatInput()
                )
              ],
            );
          }
        ),
      ),
    );
  }
}