import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state_builder.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/friends/friends.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/screens/sub/friends_list.dart';
import 'package:privacy_of_animal/screens/sub/friends_request_list.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/utils/stream_snackbar.dart';

class FriendsScreen extends StatefulWidget {
  @override
  _FriendsScreenState createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> with SingleTickerProviderStateMixin{

  final FriendsBloc _friendsBloc = sl.get<FriendsBloc>();
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _friendsBloc.emitEvent(FriendsEventStateClear());
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: primaryBlue,
          actions: [
            BlocBuilder(
              bloc: _friendsBloc,
              builder: (context, FriendsState state){
                if(state.isFriendsNotificationToggleFailed) {
                  _friendsBloc.emitEvent(FriendsEventStateClear());
                  streamSnackbar(context, '알림 설정에 실패하였습니다.');
                }
                return IconButton(
                  icon: Icon(sl.get<CurrentUser>().friendsNotification
                    ? Icons.notifications
                    : Icons.notifications_off),
                  onPressed: () => _friendsBloc.emitEvent(FriendsEventFriendsNotification())
                );
              }
            )
          ],
          bottom: TabBar(
            tabs: [
              Tab(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('친구'),
                  SizedBox(width: 10.0),
                  BlocBuilder(
                    bloc: _friendsBloc,
                    builder: (context, FriendsState state){
                      if(state.isFriendsIncreased && sl.get<CurrentUser>().friendsList.isNotEmpty) {
                        return Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle
                          ),
                          child: Text(sl.get<CurrentUser>().friendsList.length.toString())
                        );
                      }
                      return Container();
                    }
                  )
                ],
              )),
              Tab(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('친구신청'),
                  SizedBox(width: 10.0),
                  BlocBuilder(
                    bloc: _friendsBloc,
                    builder: (context, FriendsState state){
                      if(state.isRequestIncreased && sl.get<CurrentUser>().requestList.isNotEmpty) {
                        return Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle
                          ),
                          child: Text(sl.get<CurrentUser>().requestList.length.toString())
                        );
                      }
                      return Container();
                    },
                  )
                ],
              ))
            ],
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0
            ),
            unselectedLabelColor: Colors.white.withOpacity(0.2),
            controller: _tabController,
          ),
        ),
        body: TabBarView(
          children: [
            FriendsList(friendsBloc: _friendsBloc),
            FriendsRequestList(friendsBloc: _friendsBloc)
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}