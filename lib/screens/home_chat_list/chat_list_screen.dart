import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state_builder.dart';
import 'package:privacy_of_animal/logics/chat_list/chat_list.dart';
import 'package:privacy_of_animal/logics/global/current_user.dart';
import 'package:privacy_of_animal/resources/resources.dart';
import 'package:privacy_of_animal/screens/home_chat_list/chat_list_item.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/utils/bloc_snackbar.dart';

class ChatListScreen extends StatefulWidget {
  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {

  final ChatListBloc _chatListBloc = sl.get<ChatListBloc>();

  @override
  void initState() {
    super.initState();
    _chatListBloc.emitEvent(ChatListEventStateClear());
    initializeDateFormatting();
  }

  @override
  void dispose() {
    _chatListBloc.emitEvent(ChatListEventStateClear());
    super.dispose();
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
        bloc: _chatListBloc,
        builder: (context, ChatListState state){
          if(sl.get<CurrentUser>().isChatListEmpty()){
            return Center(child: Text('아직 대화기록이 없습니다.'));
          }
          if(state.isDeleteLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if(state.isDeleteFailed) {
            BlocSnackbar.show(context, "채팅을 지우는데 실패했습니다.");
            _chatListBloc.emitEvent(ChatListEventStateClear());
          }
          return ListView.builder(
            padding: EdgeInsets.all(10.0),
            itemCount: sl.get<CurrentUser>().chatListLength,
            itemBuilder: (context,index) {
              return ChatListItem(chatListModel: sl.get<CurrentUser>().getChatListModel(index));
            }
          );
        }
      )
    );
  }
}