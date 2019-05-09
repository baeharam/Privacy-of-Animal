import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state_builder.dart';
import 'package:privacy_of_animal/logics/tag_chat/tag_chat.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';

class TagChatInput extends StatefulWidget {
  @override
  TagChatInputState createState() => TagChatInputState();
}

class TagChatInputState extends State<TagChatInput> {
  final TextEditingController _textEditingController = TextEditingController();
  final TagChatBloc _tagChatBloc = sl.get<TagChatBloc>();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey, width: 0.5)
        ), 
        color: Colors.white
      ),
      child: Row(
        children: <Widget>[
          // Edit text
          Flexible(
            child: Container(
              padding: const EdgeInsets.only(left: 20.0),
              child: BlocBuilder(
                bloc: _tagChatBloc,
                builder: (context, TagChatState state){
                  return TextField(
                    decoration: InputDecoration.collapsed(
                      hintText: '답변을 입력하세요.',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    controller: _textEditingController,
                    enableInteractiveSelection: state.isSendEnable?true:false,
                  );
                }
              ),
            ),
          ),

          // Button send message
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: BlocBuilder(
                bloc: _tagChatBloc,
                builder: (context, TagChatState state){
                  return IconButton(
                    icon: Icon(Icons.send),
                    onPressed: (state.isSendEnable) ? () {
                      _tagChatBloc.emitEvent(TagChatEventUserChat(message: _textEditingController.text));
                      _textEditingController.clear();
                    } : null
                  );
                }
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}