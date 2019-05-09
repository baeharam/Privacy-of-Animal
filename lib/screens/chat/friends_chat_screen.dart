import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state_builder.dart';
import 'package:privacy_of_animal/logics/global/current_user.dart';
import 'package:privacy_of_animal/logics/friends_chat/friends_chat.dart';
import 'package:privacy_of_animal/models/chat_model.dart';
import 'package:privacy_of_animal/models/user_model.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/screens/chat/friends_chat_builder.dart';
import 'package:privacy_of_animal/utils/bloc_snackbar.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:intl/date_symbol_data_local.dart';

class FriendsChatScreen extends StatefulWidget {

  final String chatRoomID;
  final UserModel receiver;

  FriendsChatScreen({@required this.chatRoomID,@required this.receiver});

  @override
  _FriendsChatScreenState createState() => _FriendsChatScreenState();
}

class _FriendsChatScreenState extends State<FriendsChatScreen> {

  final ScrollController scrollController = ScrollController();
  final TextEditingController messageController = TextEditingController();
  final FriendsChatBloc friendsChatBloc = sl.get<FriendsChatBloc>();

  ChatBuilder _chatBuilder;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    sl.get<CurrentUser>().initCurrentChatUID(widget.receiver.uid);
  }

  @override
  void dispose() {
    messageController.dispose();
    scrollController.dispose();
    sl.get<CurrentUser>().disposeCurrentChatUID();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    _chatBuilder ??= ChatBuilder(
      context: context,
      receiver: widget.receiver
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '채팅',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
        actions: [
          BlocBuilder(
            bloc: friendsChatBloc,
            builder: (context, FriendsChatState state){
              return IconButton(
                icon: sl.get<CurrentUser>().chatRoomNotification[widget.receiver.uid]
                ? Icon(Icons.notifications)
                : Icon(Icons.notifications_off),
                onPressed: () => friendsChatBloc.emitEvent(FriendsChatEventNotification(
                  otherUserUID: widget.receiver.uid
                )),
              );
            }
          )
        ],
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: primaryBlue
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: BlocBuilder(
              bloc: friendsChatBloc,
              builder: (context, FriendsChatState state){
                if(state.isMessageReceived || state.isInitial ){
                  _chatBuilder.messages = sl.get<CurrentUser>().chatHistory[widget.receiver.uid];
                }
                return ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemBuilder: (context,index) => 
                    _chatBuilder.buildMessage(index),
                  itemCount: _chatBuilder.messageLength,
                  reverse: true,
                  controller: scrollController,
                );
              }
            ),
          ),
          Row(
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
                    controller: messageController,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
              ),
              Material(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  child: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      if(messageController.text.isEmpty){
                        BlocSnackbar.show(context, '메시지를 입력하세요.');
                      }
                      else {
                        friendsChatBloc.emitEvent(FriendsChatEventMyChatUpdate(
                          chatModel: ChatModel(
                            content: messageController.text,
                            from: sl.get<CurrentUser>().uid,
                            to: widget.receiver.uid,
                            timeStamp: Timestamp.fromDate(DateTime.now())
                          ),
                          otherUserUID: widget.receiver.uid
                        ));
                        friendsChatBloc.emitEvent(FriendsChatEventMessageSend(
                          content: messageController.text,
                          receiver: widget.receiver.uid,
                          chatRoomID: widget.chatRoomID
                        ));
                        messageController.clear();
                      }
                    },
                    color: Colors.black,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}