import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state_builder.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/random_chat/random_chat.dart';
import 'package:privacy_of_animal/models/chat_model.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/utils/stream_snackbar.dart';

class RandomChatInput extends StatefulWidget {

  final String receiverUID;
  final String chatRoomID;

  const RandomChatInput({Key key, 
    @required this.receiverUID,
    @required this.chatRoomID
  }) 
    : super(key: key);

  @override
  _RandomChatInputState createState() => _RandomChatInputState();
}

class _RandomChatInputState extends State<RandomChatInput> {

  final RandomChatBloc _randomChatBloc = sl.get<RandomChatBloc>();
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _randomChatBloc,
      builder: (context, RandomChatState state){
        if(state.isChatFinished){
          return Container(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text('상대방이 나갔습니다.'),
          );
        }
        return Row(
          children: <Widget>[
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  style: TextStyle(color: Colors.black, fontSize: 15.0),
                  decoration: InputDecoration.collapsed(
                    hintText: '메시지를 입력하세요.',
                    hintStyle: TextStyle(color: Colors.grey)
                  ),
                  controller: _messageController,
                ),
              ),
            ),
            Material(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if(_messageController.text.isEmpty) {
                      streamSnackbar(context,'메시지를 입력하세요.');
                    } else {
                      _randomChatBloc.emitEvent(
                      RandomChatEventMessageSend(
                        chatModel: ChatModel(
                          from: sl.get<CurrentUser>().uid,
                          to: widget.receiverUID,
                          content: _messageController.text,
                          timeStamp: Timestamp.fromDate(DateTime.now())
                        ),
                        chatRoomID: widget.chatRoomID
                      ));
                      _messageController.clear();
                    }
                  },
                  color: Colors.black,
                ),
              ),
            )
          ],
        ); 
      }
    );
  }
}