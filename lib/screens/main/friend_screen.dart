import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state_builder.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/logics/friends/friends.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/screens/main/other_profile_screen.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/utils/stream_snackbar.dart';
import 'package:privacy_of_animal/widgets/progress_indicator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class FriendScreen extends StatefulWidget {
  @override
  _FriendScreenState createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> with SingleTickerProviderStateMixin{

  final FriendsBloc friendsBloc = sl.get<FriendsBloc>();
  TabController tabController;
  int friendsListLength = -1;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void _showAlertForBlock(String userToBlock) {
    Alert(
      context: context,
      title: '정말로 차단하시겠습니까?',
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
              color: Colors.white
            ),
          ),
          color: primaryPink,
        ),
        DialogButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            '아니오',
            style: TextStyle(
              color: Colors.white
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
          bottom: TabBar(
            tabs: [
              Tab(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('친구'),
                  SizedBox(width: 10.0),
                  StreamBuilder<QuerySnapshot>(
                    stream: sl.get<FirebaseAPI>().getFirestore()
                      .collection(firestoreUsersCollection).document(sl.get<CurrentUser>().uid)
                      .collection(firestoreFriendsSubCollection).where(firestoreFriendsField, isEqualTo: true)
                      .snapshots(),
                    builder: (context, snapshot){
                      if(snapshot.hasData && snapshot.data.documents.isNotEmpty){
                        if(friendsListLength==-1 || friendsListLength>snapshot.data.documents.length) {
                          return Container();
                        }
                        friendsListLength = snapshot.data.documents.length;
                        return Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle
                          ),
                          child: Text('${snapshot.data.documentChanges.length}')
                        );
                      }
                      return Container();
                    },
                  )
                ],
              )),
              Tab(child: Text('친구신청'))
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
    return StreamBuilder<QuerySnapshot>(
      stream: sl.get<FirebaseAPI>().getFirestore()
        .collection(firestoreUsersCollection).document(sl.get<CurrentUser>().uid)
        .collection(firestoreFriendsSubCollection).where(firestoreFriendsField, isEqualTo: true)
        .snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasData && snapshot.data.documents.length!=0){
          friendsBloc.emitEvent(FriendsEventFetchFriendsList(
            friends: snapshot.data.documents));
        }
        return BlocBuilder(
          bloc: friendsBloc,
          builder: (context, FriendsState state){
            if(state.isFriendsFetchFailed){
              return Center(child: Text('친구목록을 불러오는데 실패했습니다.'));
            }
            if(state.isLoading) {
              return CustomProgressIndicator();
            }
            if(state.isFriendsFetchSucceeded && state.friends.length!=0) {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: state.friends.length,
                itemBuilder: (context,index) => _buildFriendsItem(state.friends[index]),
              );
            }
            return Center(child: Text('친구가 없습니다.'));
          }
        );
      }
    );
  }

  Widget _buildFriendsRequestList() {
    return StreamBuilder<QuerySnapshot>(
      stream: sl.get<FirebaseAPI>().getFirestore()
        .collection(firestoreUsersCollection).document(sl.get<CurrentUser>().uid)
        .collection(firestoreFriendsSubCollection).where(firestoreFriendsField, isEqualTo: false)
        .snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasData && snapshot.data.documents.length!=null){
          friendsBloc.emitEvent(FriendsEventFetchFriendsRequestList(
            friendsRequest: snapshot.data.documents));
        }
        return BlocBuilder(
          bloc: friendsBloc,
          builder: (context, FriendsState state){
            if(state.isFriendsRequestFetchFailed){
              return Center(child: Text('친구 신청 목록을 불러오는데 실패했습니다.'));
            }
            if(state.isLoading) {
              return CustomProgressIndicator();
            }
            if(state.isFriendsRequestFetchSucceeded && state.friendsRequest.length!=0) {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: state.friendsRequest.length,
                itemBuilder: (context,index) => _buildFriendsRequestItem(state.friendsRequest[index]),
              );
            }
            return Center(child: Text('친구신청이 없습니다.'));
          }
        );
      }
    );
  }

  Widget _buildFriendsItem(DocumentSnapshot user) {
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
                  image: AssetImage(user.data[firestoreFakeProfileField][firestoreAnimalImageField]),
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
                  user.data[firestoreFakeProfileField][firestoreNickNameField],
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  user.data[firestoreRealProfileField][firestoreNameField],
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0
                  ),
                )
              ],
            ),
          ),
          Container(
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
            onTap: () { _showAlertForBlock(user.documentID); }
          )
        ],
      ),
    );
  }

  Widget _buildFriendsRequestItem(DocumentSnapshot user) {
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
                  image: AssetImage(user.data[firestoreFakeProfileField][firestoreAnimalImageField]),
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
                  user.data[firestoreFakeProfileField][firestoreNickNameField],
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  user.data[firestoreRealProfileField][firestoreNameField],
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
            onTap: () => friendsBloc.emitEvent(FriendsEventRequestAccept(user: user.documentID)),
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
            onTap: () => friendsBloc.emitEvent(FriendsEventRequestReject(user: user.documentID)),
          )
        ],
      ),
    );
  }
}