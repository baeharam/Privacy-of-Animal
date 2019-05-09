import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state_builder.dart';
import 'package:privacy_of_animal/logics/global/current_user.dart';
import 'package:privacy_of_animal/logics/random_chat/random_chat.dart';
import 'package:privacy_of_animal/models/user_model.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/screens/chat/chat_builder.dart';
import 'package:privacy_of_animal/screens/chat/random_chat_input.dart';
import 'package:privacy_of_animal/utils/back_button_dialog.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:privacy_of_animal/utils/bloc_navigator.dart';

class RandomChatScreen extends StatefulWidget {

  final String chatRoomID;
  final UserModel receiver;

  RandomChatScreen({@required this.chatRoomID,@required this.receiver});

  @override
  _RandomChatScreenState createState() => _RandomChatScreenState();
}

class _RandomChatScreenState extends State<RandomChatScreen> {

  final ScrollController _scrollController = ScrollController();
  final RandomChatBloc _randomChatBloc = sl.get<RandomChatBloc>();

  ChatBuilder _chatBuilder;
  bool _isReceiverOut = false;

  @override
  void initState() {
    super.initState();
    _randomChatBloc.emitEvent(RandomChatEventStateClear());
    _randomChatBloc.emitEvent(RandomChatEventConnect(
      chatRoomID: widget.chatRoomID,
      otherUserUID: widget.receiver.uid
    ));

    initializeDateFormatting();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    sl.get<CurrentUser>().randomChat.clear();
    _randomChatBloc.emitEvent(RandomChatEventDisconnect());
    _randomChatBloc.emitEvent(RandomChatEventStateClear());
  }

  @override
  Widget build(BuildContext context) {

    _chatBuilder ??= ChatBuilder(
      context: context,
      receiver: widget.receiver
    );

    assert(_chatBuilder!=null);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '채팅',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: primaryBlue,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () =>
              _randomChatBloc.emitEvent(RandomChatEventRestart(chatRoomID: widget.chatRoomID)),
          )
        ],
      ),
      body: WillPopScope(
        onWillPop: () { 
          if(_isReceiverOut) {
            _randomChatBloc.emitEvent(RandomChatEventOut(chatRoomID: widget.chatRoomID));
            return Future.value(true);
          } else {
            return BackButtonAction.dialogChatExit(context, widget.chatRoomID);
          }
        },
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 10.0),
              child: Text('낯선 상대와 연결되었습니다.'),
            ),
            Flexible(
              child: BlocBuilder(
                bloc: _randomChatBloc,
                builder: (blocContext, RandomChatState state){
                  if(state.isChatFinished) {
                    _isReceiverOut = true;
                  }
                  if(state.isMessageReceived) {
                    _chatBuilder.messages = sl.get<CurrentUser>().randomChat;
                  }
                  if(state.isGetOutSucceeded) {
                    if(!_isReceiverOut) {
                      BlocNavigator.pop(context);
                      BlocNavigator.pop(context);
                    } else {
                      BlocNavigator.pop(context);
                    }
                  }
                  if(state.isRestartSucceeded) {
                    BlocNavigator.pushReplacementNamed(context, routeRandomLoading);
                  }
                  return ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemBuilder: (context,index) => _chatBuilder.buildMessage(index),
                    itemCount: _chatBuilder.messageLength,
                    reverse: true,
                    controller: _scrollController,
                  );
                }
              ),
            ),
            RandomChatInput(
              receiverUID: widget.receiver.uid,
              chatRoomID: widget.chatRoomID
            ),
          ],
        ),
      ),
    );
  }
}