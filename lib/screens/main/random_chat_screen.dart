import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state_builder.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/random_chat/random_chat.dart';
import 'package:privacy_of_animal/logics/random_loading/random_loading.dart';
import 'package:privacy_of_animal/models/chat_model.dart';
import 'package:privacy_of_animal/models/user_model.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/screens/main/other_profile_screen.dart';
import 'package:privacy_of_animal/utils/back_button_dialog.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:privacy_of_animal/utils/stream_navigator.dart';

class RandomChatScreen extends StatefulWidget {

  final String chatRoomID;
  final UserModel receiver;

  RandomChatScreen({@required this.chatRoomID,@required this.receiver});

  @override
  _RandomChatScreenState createState() => _RandomChatScreenState();
}

class _RandomChatScreenState extends State<RandomChatScreen> {

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _messageFocusNode = FocusNode();
  final GlobalKey<ScaffoldState> _scaffoldKey =GlobalKey<ScaffoldState>();

  final RandomChatBloc _randomChatBloc = sl.get<RandomChatBloc>();
  final RandomLoadingBloc _randomLoadingBloc = sl.get<RandomLoadingBloc>();

  List<ChatModel> _messages = List<ChatModel>();
  bool _isReceiverOut = false;

  @override
  void initState() {
    super.initState();
    _randomChatBloc.emitEvent(RandomChatEventStateClear());
    initializeDateFormatting();
    _randomChatBloc.emitEvent(RandomChatEventConnect(
      chatRoomID: widget.chatRoomID,
      otherUserUID: widget.receiver.uid
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
    _messageFocusNode.dispose();
    _scrollController.dispose();
    sl.get<CurrentUser>().randomChat.clear();
    _randomChatBloc.emitEvent(RandomChatEventDisconnect());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                  if(state.isMessageReceived) {
                    _messages = sl.get<CurrentUser>().randomChat;
                  }
                  if(state.isGetOutSucceeded) {
                    if(!_isReceiverOut) {
                      StreamNavigator.pop(context);
                      StreamNavigator.pop(context);
                    } else {
                      StreamNavigator.pop(context);
                    }
                  }
                  if(state.isRestartSucceeded) {
                    StreamNavigator.pushReplacementNamed(context, routeRandomLoading);
                  }

                  return ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemBuilder: (context,index) => _buildMessage(index,_messages[index]),
                    itemCount: _messages.length,
                    reverse: true,
                    controller: _scrollController,
                  );
                }
              ),
            ),
            BlocBuilder(
              bloc: _randomChatBloc,
              builder: (context, RandomChatState state){
                if(state.isChatFinished){
                  _isReceiverOut = true;
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
                          style: TextStyle(color: primaryGreen, fontSize: 15.0),
                          decoration: InputDecoration.collapsed(
                            hintText: '메시지를 입력하세요.',
                            hintStyle: TextStyle(color: Colors.grey)
                          ),
                          controller: _messageController,
                          focusNode: _messageFocusNode,
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
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text('메시지를 입력하세요.'),
                                duration: const Duration(milliseconds: 100),
                              ));
                            } else {
                              _randomChatBloc.emitEvent(
                              RandomChatEventMessageSend(
                                chatModel: ChatModel(
                                  from: sl.get<CurrentUser>().uid,
                                  to: widget.receiver.uid,
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessage(int index, ChatModel chat) {
    /// [내가 보내는 메시지]
    if(chat.from == sl.get<CurrentUser>().uid){
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          _isLastRight(index) ?
          Container(
            margin: EdgeInsets.only(right: 10.0,bottom: 5.0),
            child: Text(
              DateFormat('kk:mm','ko')
                .format(DateTime.fromMillisecondsSinceEpoch(chat.timeStamp.millisecondsSinceEpoch)),
                style: TextStyle(color: Colors.grey,fontSize: 12.0),
            ),
          ) : Container(),
          Flexible(
            child: Column(
              children: <Widget>[
                SizedBox(height: 5.0),
                Container(
                  child: Text(
                    chat.content,
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(15.0,10.0,15.0,10.0),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(3.0)
                  ),
                  margin: _isLastRight(index) ? const EdgeInsets.only(right: 10.0,bottom: 5.0)
                    : const EdgeInsets.only(right: 10.0),
                ),
              ],
            ),
          ),
        ],
      );
      /// [상대방이 보내는 메시지]
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          _isFirstLeft(index) ?
          Column(
            children: [
              Text(
                widget.receiver.fakeProfileModel.nickName,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600
                ),
              ),
              SizedBox(height: 5.0),
              Container(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: GestureDetector(
                child: CircleAvatar(
                  backgroundImage: AssetImage(widget.receiver.fakeProfileModel.animalImage),
                  backgroundColor: Colors.transparent,
                ),
                onTap: () => Navigator.push(context, MaterialPageRoute(
                  builder: (context) => OtherProfileScreen(user: widget.receiver)
                )),
              ))
            ]
          ) : Container(width: 40.0),
          Flexible(
            child: Container(
              child: Text(
                chat.content,
                style: TextStyle(color: Colors.white),
              ),
              padding: EdgeInsets.fromLTRB(15.0,10.0,15.0,10.0),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(8.0)
              ),
              margin: EdgeInsets.only(left: 10.0,bottom: 5.0)
            ),
          ),
          _isLastLeft(index) ?
          Container(
          margin: EdgeInsets.only(left: 10.0,bottom: 5.0),
          child: Text(
            DateFormat('kk:mm','ko')
              .format(DateTime.fromMillisecondsSinceEpoch(chat.timeStamp.millisecondsSinceEpoch)),
              style: TextStyle(color: Colors.grey,fontSize: 12.0),
          ),
          ) : Container()
        ],
      );
    }
  }

  bool _isFirstLeft(int index) {
    if((index<_messages.length-1 && _messages!=null && _messages[index+1].from == sl.get<CurrentUser>().uid)
     || (index == _messages.length-1)) {
       return true;
     } else {
       return false;
     }
  }

  bool _isLastLeft(int index) {
    if((index>0 && _messages!=null && _messages[index-1].from == sl.get<CurrentUser>().uid) 
      || index==0){
        return true;
    } else {
      return false;
    }
  }

  bool _isLastRight(int index) {
    if((index>0 && _messages!=null && _messages[index-1].to == sl.get<CurrentUser>().uid) 
      || index==0){
        return true;
    } else {
      return false;
    }
  }
}