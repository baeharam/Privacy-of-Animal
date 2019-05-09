import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state_builder.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/friends/friends.dart';
import 'package:privacy_of_animal/screens/home_friends/friends_request_item.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/utils/bloc_snackbar.dart';
import 'package:privacy_of_animal/widgets/progress_indicator.dart';

class FriendsRequestList extends StatelessWidget {

  final FriendsBloc friendsBloc;

  FriendsRequestList({@required this.friendsBloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: friendsBloc,
      builder: (context, FriendsState state){
        if(state.isRequestRefreshFailed){
          return Center(child: Text('친구 신청 목록을 불러오는데 실패했습니다.'));
        }
        if(state.isRequestRefreshLoading) {
          return CustomProgressIndicator();
        }
        if(state.isFriendsAcceptSucceeded){
          BlocSnackbar.show(context, '친구를 수락하였습니다.');
          friendsBloc.emitEvent(FriendsEventStateClear());
        }
        if(state.isFriendsRejectSucceeded){
          BlocSnackbar.show(context, '친구를 거절하였습니다.');
          friendsBloc.emitEvent(FriendsEventStateClear());
        }
        if(sl.get<CurrentUser>().requestFromList.isNotEmpty) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: sl.get<CurrentUser>().requestFromList.length,
            itemBuilder: (context,index) 
              => FriendsRequestItem(
                requestingUser: sl.get<CurrentUser>().requestFromList[index],
                state: state,
                friendsBloc: friendsBloc,
              )
          );
        }
        return Center(child: Text('친구신청이 없습니다.'));
      }
    );
  }
}