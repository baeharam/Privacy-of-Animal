import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_helpers.dart';
import 'package:privacy_of_animal/logics/tag_chat/tag_chat.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/screens/sub/tag_chat_input.dart';
import 'package:privacy_of_animal/screens/sub/tag_chat_npc.dart';
import 'package:privacy_of_animal/screens/sub/tag_chat_user.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/utils/stream_navigator.dart';
import 'package:privacy_of_animal/utils/stream_snackbar.dart';
import 'package:privacy_of_animal/widgets/primary_button.dart';
import 'package:privacy_of_animal/widgets/progress_indicator.dart';

class TagChatScreen extends StatefulWidget {
  @override
  _TagChatScreenState createState() => _TagChatScreenState();
}

class _TagChatScreenState extends State<TagChatScreen> {

  final TagChatBloc _tagChatBloc = sl.get<TagChatBloc>();
  final ScrollController _scrollController = ScrollController();
  List<Widget> widgets = [];
  Widget bottomWidget = Container();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder(
        bloc: _tagChatBloc,
        builder: (context, TagChatState state){
          if(state.isDetailStoreSucceeded){
            StreamNavigator.pushNamedAndRemoveAll(context, routePhotoDecision);
          }
          if(state.isDetailStoreFailed){
            streamSnackbar(context,'제출에 실패했습니다.');
          }
          if(state.isNPC){
            if(state.isInitial && state.isBegin){
              _tagChatBloc.emitEvent(TagChatEventNPC(isInitial: true));
            }
            widgets.add(TagChatNPC(message: state.messageNPC,isBegin: state.isBegin));
            _tagChatBloc.emitEvent(TagChatEventNothing(isNPCDone: false));
          }
          if(state.isUser){
            widgets.add(TagChatUser(message: state.messageUser));
            _tagChatBloc.emitEvent(TagChatEventNothing(isNPCDone: false));
            _tagChatBloc.emitEvent(TagChatEventNPC(isInitial: false));
          }
          return Column(
            children: <Widget>[
              Flexible(
                child: ScrollConfiguration(
                  behavior: NoScrollGlow(),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 30.0),
                    itemCount: widgets.length,
                    itemBuilder: (context,index) => widgets[index],
                    controller: _scrollController,
                  ),
                ),
              ),
              state.showSubmitButton 
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: PrimaryButton(
                    color: primaryBeige,
                    text: '제출 하기',
                    callback: ()=>_tagChatBloc.emitEvent(TagChatEventComplete())
                  )
                ) 
              : (state.isDetailStoreLoading 
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: CustomProgressIndicator()
                  )
                : TagChatInput(scrollController: _scrollController)
              )
            ],
          );
        }
      ),
    );
  }
}

class NoScrollGlow extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}