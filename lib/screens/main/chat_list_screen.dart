import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state_builder.dart';
import 'package:privacy_of_animal/logics/chat_list/chat_list.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/models/chat_list_model.dart';
import 'package:privacy_of_animal/resources/resources.dart';
import 'package:privacy_of_animal/screens/main/friends_chat_screen.dart';
import 'package:privacy_of_animal/screens/main/other_profile_screen.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/widgets/progress_indicator.dart';

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
    initializeDateFormatting('ko');
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
      body: StreamBuilder<QuerySnapshot>(
        stream: sl.get<FirebaseAPI>().getFirestore()
          .collection(firestoreFriendsMessageCollection)
          .where('$firestoreChatDeleteField.${sl.get<CurrentUser>().uid}',isEqualTo: false)
          .snapshots(),
        builder: (context, snapshot){
          if(snapshot.hasData && snapshot.data.documents.isNotEmpty){
            chatListBloc.emitEvent(ChatListEventFetchList(documents: snapshot.data.documents));
            return BlocBuilder(
              bloc: chatListBloc,
              builder: (context, ChatListState state){
                if(state.isFailed) {
                  return Center(child: Text('채팅 목록을 불러오는데 실패했습니다.'));
                }
                if(state.isSucceeded) {
                  chatList = state.chatList;
                  return ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemCount: chatList.length,
                    itemBuilder: (context,index) => _buildChatRoom(chatList[index]),
                  );
                }
                return CustomProgressIndicator();
              }
            );
          }
          return Center(child: Text('채팅이 없습니다.'),);
        },
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
                          Text(
                            chatListModel.nickName,
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
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
      onDismissed: (direction) {sl.get<ChatListBloc>().emitEvent(ChatListEventDeleteChatRoom(
        chatRoomID: chatListModel.chatRoomID
      ));},
    );
  }
}