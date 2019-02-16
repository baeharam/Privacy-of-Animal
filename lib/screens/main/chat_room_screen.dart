import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state_builder.dart';
import 'package:privacy_of_animal/logics/chat_list/chat_list.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/models/chat_list_model.dart';
import 'package:privacy_of_animal/resources/resources.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/widgets/progress_indicator.dart';

class ChatRoomScreen extends StatefulWidget {
  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {

  final ChatListBloc chatListBloc = sl.get<ChatListBloc>();

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
        backgroundColor: primaryBlue
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: sl.get<FirebaseAPI>().getFirestore()
          .collection(firestoreMessageCollection)
          .where(firestoreChatUsersField,arrayContains: sl.get<CurrentUser>().uid)
          .snapshots(),
        builder: (context, snapshot){
          if(snapshot.hasData && snapshot.data.documents.length!=0){
            return BlocBuilder(
              bloc: chatListBloc,
              builder: (context, ChatListState state){
                if(state.isLoading){
                  chatListBloc.emitEvent(ChatListEventFetchList(documents: snapshot.data.documents));
                  return CustomProgressIndicator();
                }
                if(state.isSucceeded){
                  return ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemCount: state.chatList.length,
                    itemBuilder: (context,index) => _buildChatRoom(state.chatList[index]),
                  );
                }
                return Container();
              }
            );
          }
          return Container();
        },
      )
    );
  }

  Widget _buildChatRoom(ChatListModel chatListModel) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(backgroundImage: AssetImage(chatListModel.profileImage)),
          Column(
            children: <Widget>[
              Text(chatListModel.nickName),
              Text(chatListModel.lastMessage)
            ],
          ),
          Text(
            DateFormat('kk:mm','ko')
                .format(DateTime.fromMillisecondsSinceEpoch(
                  chatListModel.lastTimestamp.millisecondsSinceEpoch))
          )
        ],
      )
    );
  }
}