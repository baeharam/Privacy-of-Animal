import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state_builder.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/friends/friends.dart';
import 'package:privacy_of_animal/screens/chat/friends_chat_screen.dart';
import 'package:privacy_of_animal/screens/home_friends/friends_item.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/utils/bloc_snackbar.dart';
import 'package:privacy_of_animal/widgets/progress_indicator.dart';

class FriendsList extends StatelessWidget {

  final FriendsBloc friendsBloc;

  FriendsList({@required this.friendsBloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: friendsBloc,
      builder: (context, FriendsState state){
        if(state.isFriendsRefreshFailed){
          return Center(child: Text('친구목록을 불러오는데 실패했습니다.'));
        }
        if(state.isFriendsRefreshLoading) {
          return CustomProgressIndicator();
        }
        if(state.isFriendsChatSucceeded){
          WidgetsBinding.instance.addPostFrameCallback((_){
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => FriendsChatScreen(
                chatRoomID: state.chatRoomID,
                receiver: state.receiver,
              )
            ));
          });
          friendsBloc.emitEvent(FriendsEventStateClear());
        }
        if(state.isFriendsBlockSucceeded) {
          BlocSnackbar.show(context, '친구를 삭제하였습니다.');
          friendsBloc.emitEvent(FriendsEventStateClear());
        }
        if(sl.get<CurrentUser>().friendsList.isNotEmpty) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: sl.get<CurrentUser>().friendsList.length,
            itemBuilder: (context,index) => 
              FriendsItem(
                 friends: sl.get<CurrentUser>().friendsList[index],
                 state: state,
                 friendsBloc: friendsBloc,
                 context: context,
              )
          );
        }
        return Center(child: Text('친구가 없습니다.'));
      }
    );
  }
}