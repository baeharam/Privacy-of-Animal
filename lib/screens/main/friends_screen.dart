import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state_builder.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/friends/friends.dart';
import 'package:privacy_of_animal/models/user_model.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/screens/main/friends_chat_screen.dart';
import 'package:privacy_of_animal/screens/main/other_profile_screen.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/utils/stream_snackbar.dart';
import 'package:privacy_of_animal/widgets/progress_indicator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class FriendsScreen extends StatefulWidget {
  @override
  _FriendsScreenState createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> with SingleTickerProviderStateMixin{

  final FriendsBloc friendsBloc = sl.get<FriendsBloc>();
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    sl.get<CurrentUser>().newFriendsNum = 0;
    super.dispose();
  }

  void _showAlertForBlock(UserModel userToBlock) {
    Alert(
      context: context,
      title: '정말로 차단하시겠습니까?',
      desc: '상대방의 친구 목록에서\n삭제되며 모든 대화가 사라집니다.',
      type: AlertType.warning,
      buttons: [
        DialogButton(
          onPressed: (){
            friendsBloc.emitEvent(FriendsEventBlock(user: userToBlock));
            Navigator.pop(context);
          },
          child: Text(
            '예',
            style: TextStyle(
              color: Colors.black
            ),
          ),
          color: primaryPink,
        ),
        DialogButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            '아니오',
            style: TextStyle(
              color: Colors.black
            ),
          ),
          color: primaryBeige,
        )
      ]
    ).show();
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
              bloc: friendsBloc,
              builder: (context, FriendsState state){
                if(state.isFriendsNotificationToggleFailed) {
                  streamSnackbar(context, '알림 설정에 실패하였습니다.');
                  friendsBloc.emitEvent(FriendsEventStateClear());
                }
                return IconButton(
                  icon: Icon(sl.get<CurrentUser>().friendsNotification
                    ? Icons.notifications
                    : Icons.notifications_off),
                  onPressed: () => friendsBloc.emitEvent(FriendsEventFriendsNotification())
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
                    bloc: friendsBloc,
                    builder: (context, FriendsState state){
                      int newFriendsNum = sl.get<CurrentUser>().newFriendsNum;
                      if(newFriendsNum==0) {
                        return Container();
                      }
                      return Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle
                        ),
                        child: Text(sl.get<CurrentUser>().newFriendsNum.toString())
                      );
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
                    bloc: friendsBloc,
                    builder: (context, FriendsState state){
                      int requestNum = sl.get<CurrentUser>().friendsRequestList.length;
                      if(requestNum==0) {
                        return Container();
                      }
                      return Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle
                        ),
                        child: Text(sl.get<CurrentUser>().friendsRequestList.length.toString())
                      );
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
            controller: tabController,
          ),
        ),
        body: TabBarView(
          children: [
            _buildFriendsList(),
            _buildFriendsRequestList()
          ],
          controller: tabController,
        ),
      ),
    );
  }

  Widget _buildFriendsList() {
    return BlocBuilder(
      bloc: friendsBloc,
      builder: (context, FriendsState state){
        if(state.isFriendsFetchFailed){
          return Center(child: Text('친구목록을 불러오는데 실패했습니다.'));
        }
        if(state.isFriendsFetchLoading) {
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
          streamSnackbar(context, '친구를 삭제하였습니다.');
          friendsBloc.emitEvent(FriendsEventStateClear());
        }
        if(sl.get<CurrentUser>().friendsList.isNotEmpty) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: sl.get<CurrentUser>().friendsList.length,
            itemBuilder: (context,index) => _buildFriendsItem(sl.get<CurrentUser>().friendsList[index],state),
          );
        }
        return Center(child: Text('친구가 없습니다.'));
      }
    );
  }

  Widget _buildFriendsRequestList() {
    return BlocBuilder(
      bloc: friendsBloc,
      builder: (context, FriendsState state){
        if(state.isFriendsRequestFetchFailed){
          return Center(child: Text('친구 신청 목록을 불러오는데 실패했습니다.'));
        }
        if(state.isFriendsFetchLoading) {
          return CustomProgressIndicator();
        }
        if(state.isFriendsAcceptSucceeded){
          streamSnackbar(context, '친구를 수락하였습니다.');
          friendsBloc.emitEvent(FriendsEventStateClear());
        }
        if(state.isFriendsRejectSucceeded){
          streamSnackbar(context, '친구를 거절하였습니다.');
          friendsBloc.emitEvent(FriendsEventStateClear());
        }
        if(sl.get<CurrentUser>().friendsRequestList.isNotEmpty) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: sl.get<CurrentUser>().friendsRequestList.length,
            itemBuilder: (context,index) 
              => _buildFriendsRequestItem(sl.get<CurrentUser>().friendsRequestList[index], state),
          );
        }
        return Center(child: Text('친구신청이 없습니다.'));
      }
    );
  }

  Widget _buildFriendsItem(UserModel user, FriendsState state) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
      child: Row(
        children: [
          GestureDetector(
            child: Container(
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(user.fakeProfileModel.animalImage),
                  fit: BoxFit.cover
                ),
                borderRadius: BorderRadius.circular(5.0)
              ),
            ),
            onTap: () => Navigator.push(context, MaterialPageRoute(
              builder: (context) => OtherProfileScreen(user: user)
            )),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.fakeProfileModel.nickName,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  user.realProfileModel.name,
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
              decoration: BoxDecoration(
                border: Border.all(color: primaryGreen),
                borderRadius: BorderRadius.circular(5.0)
              ),
              child: Text(
                '대화',
                style: TextStyle(
                  color: primaryGreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0
                ),
              ),
            ),
            onTap: () => (state.isFriendsChatLoading || state.isFriendsBlockLoading) ? null :
              friendsBloc.emitEvent(FriendsEventChat(user: user)),
          ),
          SizedBox(width: 10.0),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
                borderRadius: BorderRadius.circular(5.0)
              ),
              child: Text(
                '차단',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0
                ),
              ),
            ),
            onTap: ()  => (state.isFriendsChatLoading || state.isFriendsBlockLoading) ? null :
              _showAlertForBlock(user)
          )
        ],
      ),
    );
  }

  Widget _buildFriendsRequestItem(UserModel user, FriendsState state) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
      child: Row(
        children: [
          GestureDetector(
            child: Container(
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(user.fakeProfileModel.animalImage),
                  fit: BoxFit.cover
                ),
                borderRadius: BorderRadius.circular(5.0)
              ),
            ),
            onTap: () => Navigator.push(context, MaterialPageRoute(
              builder: (context) => OtherProfileScreen(user: user)
            )),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.fakeProfileModel.nickName,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  user.realProfileModel.name,
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
              decoration: BoxDecoration(
                border: Border.all(color: primaryGreen),
                borderRadius: BorderRadius.circular(5.0)
              ),
              child: Text(
                '수락',
                style: TextStyle(
                  color: primaryGreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0
                ),
              ),
            ),
            onTap: () => (state.isFriendsAcceptLoading || state.isFriendsRejectLoading) ? null :
              friendsBloc.emitEvent(FriendsEventRequestAccept(user: user)),
          ),
          SizedBox(width: 10.0),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
                borderRadius: BorderRadius.circular(5.0)
              ),
              child: Text(
                '삭제',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0
                ),
              ),
            ),
            onTap: () => (state.isFriendsAcceptLoading || state.isFriendsRejectLoading) ? null :
              friendsBloc.emitEvent(FriendsEventRequestReject(user: user)),
          )
        ],
      ),
    );
  }
}