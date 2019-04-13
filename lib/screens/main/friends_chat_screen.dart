import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state_builder.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/friends_chat/friends_chat.dart';
import 'package:privacy_of_animal/models/chat_model.dart';
import 'package:privacy_of_animal/models/user_model.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/screens/main/other_profile_screen.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:intl/intl.dart';
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
  final FocusNode messageFocusNode = FocusNode();
  final FriendsChatBloc friendsChatBloc = sl.get<FriendsChatBloc>();
  final GlobalKey<ScaffoldState> scaffoldKey =GlobalKey<ScaffoldState>();
  List<ChatModel> messages = List<ChatModel>();

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    _initCurrentChatRoomID();
  }

  @override
  void dispose() {
    messageController.dispose();
    messageFocusNode.dispose();
    scrollController.dispose();
    _disposeCurrentChatRoomID();
    super.dispose();
  }

  void _initCurrentChatRoomID() => sl.get<CurrentUser>().currentChatUID = widget.receiver.uid;
  void _disposeCurrentChatRoomID() => sl.get<CurrentUser>().currentChatUID = '';

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
                  messages = sl.get<CurrentUser>().chatHistory[widget.receiver.uid];
                }
                return ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemBuilder: (context,index) => 
                    _buildMessage(index,messages[index]),
                  itemCount: messages.length,
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
                    style: TextStyle(color: primaryGreen, fontSize: 15.0),
                    decoration: InputDecoration.collapsed(
                      hintText: '메시지를 입력하세요.',
                      hintStyle: TextStyle(color: Colors.grey)
                    ),
                    controller: messageController,
                    focusNode: messageFocusNode,
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
                        scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text('메시지를 입력하세요.'),
                          duration: const Duration(milliseconds: 100),
                        ));
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
    if((index<messages.length-1 && messages!=null && messages[index+1].from == sl.get<CurrentUser>().uid)
     || (index == messages.length-1)) {
       return true;
     } else {
       return false;
     }
  }

  bool _isLastLeft(int index) {
    if((index>0 && messages!=null && messages[index-1].from == sl.get<CurrentUser>().uid) 
      || index==0){
        return true;
    } else {
      return false;
    }
  }

  bool _isLastRight(int index) {
    if((index>0 && messages!=null && messages[index-1].to == sl.get<CurrentUser>().uid) 
      || index==0){
        return true;
    } else {
      return false;
    }
  }
}