import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_helpers.dart';
import 'package:privacy_of_animal/logics/tag_chat/tag_chat.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/screens/sub/tag_chat_input.dart';
import 'package:privacy_of_animal/screens/sub/tag_chat_npc.dart';

class TagChatScreen extends StatefulWidget {
  @override
  _TagChatScreenState createState() => _TagChatScreenState();
}

class _TagChatScreenState extends State<TagChatScreen> {

  final TagChatBloc _tagChatBloc = TagChatBloc();
  List<Widget> widgets = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          BlocBuilder(
            bloc: _tagChatBloc,
            builder: (context, TagChatState state){
              if(state.isInitial && state.initialOrder<4){
                widgets.add(TagChatNPC(message: tagChatNPCIntro[state.initialOrder-1]));
                if(state.initialOrder==1) _tagChatBloc.emitEvent(TagChatEventBegin());
                if(state.initialOrder==3) _tagChatBloc.emitEvent(TagChatEventDone());
              }
              return Flexible(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 30.0),
                  itemCount: widgets.length,
                  itemBuilder: (context,index) => widgets[index],
                ),
              );
            }
          ),
          TagChatInput()
        ],
      ),
    );
  }
}