import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_helpers.dart';
import 'package:privacy_of_animal/logics/tag_chat/tag_chat.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/screens/sub/tag_chat_input.dart';
import 'package:privacy_of_animal/screens/sub/tag_chat_npc.dart';
import 'package:privacy_of_animal/screens/sub/tag_chat_user.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/widgets/primary_button.dart';

class TagChatScreen extends StatefulWidget {
  @override
  _TagChatScreenState createState() => _TagChatScreenState();
}

class _TagChatScreenState extends State<TagChatScreen> {

  final TagChatBloc _tagChatBloc = sl.get<TagChatBloc>();
  List<Widget> widgets = [];
  Widget bottomWidget = Container();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder(
        bloc: _tagChatBloc,
        builder: (context, TagChatState state){
          if(state.isNPC){
            widgets.add(TagChatNPC(message: state.messageNPC,isBegin: state.isBegin));
            _tagChatBloc.emitEvent(TagChatEventDone(isNPCDone: true,isUserDone: false));
            if(state.isInitial) _tagChatBloc.emitEvent(TagChatEventNPC(isInitial: true));
          }
          if(state.isUser){
            widgets.add(TagChatUser(message: state.messageUser));
            _tagChatBloc.emitEvent(TagChatEventDone(isUserDone: true,isNPCDone: false));
            _tagChatBloc.emitEvent(TagChatEventNPC(isInitial: false));
          }
          return Column(
            children: <Widget>[
              Flexible(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 30.0),
                  itemCount: widgets.length,
                  itemBuilder: (context,index) => widgets[index],
                ),
              ),
              state.showSubmitButton 
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: PrimaryButton(color: primaryBeige,text: '?? ??',callback: (){})
                ) 
              : TagChatInput()
            ],
          );
        }
      ),
    );
  }
}