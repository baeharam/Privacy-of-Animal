import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:privacy_of_animal/logics/chat_list/chat_list.dart';
import 'package:privacy_of_animal/logics/global/current_user.dart';
import 'package:privacy_of_animal/models/chat_list_model.dart';
import 'package:privacy_of_animal/resources/resources.dart';
import 'package:privacy_of_animal/screens/chat/friends_chat_screen.dart';
import 'package:privacy_of_animal/screens/other_profile/other_profile_screen.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';

class ChatListItem extends StatelessWidget {

  final ChatListModel chatListModel;

  const ChatListItem({Key key, @required this.chatListModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {

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
                              sl.get<CurrentUser>().chatRoomNotification[chatListModel.user.uid]
                              ? Icon(Icons.notifications,color: Colors.grey)
                              : Icon(Icons.notifications_off,color: Colors.grey)
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            width: ScreenUtil.width*0.5,
                            child: Text(
                              chatListModel.lastMessage,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
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
      onDismissed: (direction) {
        sl.get<ChatListBloc>().emitEvent(
          ChatListEventDeleteChatRoom(
            chatRoomID: chatListModel.chatRoomID,
            friends: chatListModel.user.uid
          )
        );
      },
    );
  }
}