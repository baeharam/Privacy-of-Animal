import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state_builder.dart';
import 'package:privacy_of_animal/logics/chat_list/chat_list.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/models/chat_list_model.dart';
import 'package:privacy_of_animal/resources/resources.dart';
import 'package:privacy_of_animal/screens/main/friends_chat_screen.dart';
import 'package:privacy_of_animal/screens/main/other_profile_screen.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';

class ChatListScreen extends StatefulWidget {
  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {

  final ChatListBloc chatListBloc = sl.get<ChatListBloc>();
  List<ChatListModel> chatList = List<ChatListModel>();

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '채팅목록',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: primaryBlue,
      ),
      body: BlocBuilder(
        bloc: chatListBloc,
        builder: (context, ChatListState state){
          if(state.isNewMessage || state.isFriendsDeleted) {
            chatList = sl.get<CurrentUser>().chatListHistory.values.toList();
          }
          if(chatList.isEmpty) {
            return Center(child: Text('아직 대화기록이 없습니다.'));
          }
          return ListView.builder(
            padding: EdgeInsets.all(10.0),
            itemCount: chatList.length,
            itemBuilder: (context,index) {
              return _buildChatRoom(chatList[index]);
            }
          );
        }
      )
    );
  }

  Widget _buildChatRoom(ChatListModel chatListModel) {

    bool isToday = chatListModel.lastTimestamp.toDate().difference(DateTime.now())
      == Duration(days: 0) ? true : false;
      
    return Dismissible(
      key: Key(chatListModel.user.uid),
      background: Container(color: Colors.black),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              child: Container(
                width: 60.0,
                height: 60.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(chatListModel.profileImage),
                    fit: BoxFit.cover
                  ),
                  borderRadius: BorderRadius.circular(5.0)
                ),
              ),
              onTap: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) => OtherProfileScreen(user: chatListModel.user)
              )),
            ),
            SizedBox(width: 20.0),
            Flexible(
              child: GestureDetector(
                child: Container(
                  width: ScreenUtil.width/1.2,
                  height: 60.0,
                  color: Colors.transparent,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                chatListModel.nickName,
                                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 10.0),
                              sl.get<CurrentUser>().chatRoomNotification[chatListModel.chatRoomID]
                              ? Icon(Icons.notifications,color: Colors.grey)
                              : Icon(Icons.notifications_off,color: Colors.grey)
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Text(chatListModel.lastMessage)
                        ],
                      ),
                      Spacer(),
                      Text(
                        !isToday ?
                        DateFormat.jm('ko')
                            .format(DateTime.fromMillisecondsSinceEpoch(
                              chatListModel.lastTimestamp.millisecondsSinceEpoch)) :
                        DateFormat('yy년 mm월 dd일')
                            .format(DateTime.fromMillisecondsSinceEpoch(
                              chatListModel.lastTimestamp.millisecondsSinceEpoch)),
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ),
                onTap: () => Navigator.push(context, MaterialPageRoute(
                  builder: (context) => FriendsChatScreen(
                    chatRoomID: chatListModel.chatRoomID,
                    receiver: chatListModel.user,
                  )
                )),
              ),
            )
          ],
        )
      ),
      onDismissed: (direction) {chatListBloc.emitEvent(ChatListEventDeleteChatRoom(
        chatRoomID: chatListModel.chatRoomID,
        friends: chatListModel.user.uid
      ));},
    );
  }
}