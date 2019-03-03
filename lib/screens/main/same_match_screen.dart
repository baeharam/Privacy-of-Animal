import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state_builder.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/logics/same_match/same_match.dart';
import 'package:privacy_of_animal/models/same_match_model.dart';
import 'package:privacy_of_animal/resources/resources.dart';
import 'package:privacy_of_animal/screens/main/other_profile_screen.dart';
import 'package:privacy_of_animal/utils/profile_hero.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/utils/stream_snackbar.dart';
import 'package:rxdart/rxdart.dart';

class SameMatchScreen extends StatefulWidget {
  @override
  _SameMatchScreenState createState() => _SameMatchScreenState();
}

class _SameMatchScreenState extends State<SameMatchScreen> {

  final SameMatchBloc sameMatchBloc = sl.get<SameMatchBloc>();
  SameMatchModel sameMatchModel;

  Stream<QuerySnapshot> _getFriendsStream() {
    // 친구신청을 보냈는지 판단하는 Stream
    Stream<QuerySnapshot> requestStreamTo = sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreUsersCollection)
      .document(sameMatchModel.userInfo.documentID)
      .collection(firestoreFriendsSubCollection)
      .where(uidCol, isEqualTo: sl.get<CurrentUser>().uid)
      .where(firestoreFriendsField, isEqualTo: false).snapshots();

    // 친구신청을 받았는지 판단하는 Stream
    Stream<QuerySnapshot> requestStreamFrom = sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreUsersCollection)
      .document(sl.get<CurrentUser>().uid)
      .collection(firestoreFriendsSubCollection)
      .where(uidCol, isEqualTo: sameMatchModel.userInfo.documentID)
      .where(firestoreFriendsField, isEqualTo: false).snapshots();

    // 친구인지 판단하는 Stream
    Stream<QuerySnapshot> friendsStream = sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreUsersCollection)
      .document(sameMatchModel.userInfo.documentID)
      .collection(firestoreFriendsSubCollection)
      .where(uidCol, isEqualTo: sl.get<CurrentUser>().uid)
      .where(firestoreFriendsField, isEqualTo: true).snapshots();

    return Observable.combineLatest3(requestStreamTo, friendsStream, requestStreamFrom,(s1,s2, s3){
      if(s1.documents.isNotEmpty || s2.documents.isNotEmpty || s3.documents.isNotEmpty){
        return s1.documents.isNotEmpty ? s1 : (s2.documents.isNotEmpty ? s2 : s3);
      } else {
        return s1;
      }
    });
  }

  Widget _loadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(height: 20.0),
          Text(
            '관심사가 비슷한 상대를 찾고 있습니다...',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15.0
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTag(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: color,
          width: 3.0
        ),
        color: Colors.white.withOpacity(0.2)
      ),
      child: Text(
        '# $text',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget _buildProfileInfo(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 5.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 3.0
        ),
        color: Colors.white.withOpacity(0.2)
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: primaryBlue,
        title: Text(
          '관심사 매칭',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => sameMatchBloc.emitEvent(SameMatchEventFindUser()),
          )
        ],
      ),
      body: BlocBuilder(
        bloc: sameMatchBloc,
        builder: (context, SameMatchState state){
          if(state.isFindLoading){
            return _loadingWidget();
          }
          if(state.isFindFailed){
            streamSnackbar(context,'데이터를 불러오는데 실패했습니다.');
            sameMatchBloc.emitEvent(SameMatchEventStateClear());
          }
          if(state.isRequestSucceeded){
            streamSnackbar(context,'친구신청에 성공했습니다.');
            sameMatchBloc.emitEvent(SameMatchEventStateClear());
          }
          if(state.isRequestFailed){
            streamSnackbar(context,'친구신청에 실패했습니다.');
            sameMatchBloc.emitEvent(SameMatchEventStateClear());
          }
          if(state.isFindSucceeded) {
            if(state.sameMatchModel.tagTitle==null){
              return Center(child: Text('아직까지 맞는 상대가 없습니다.'));
            } else {
              sameMatchModel = state.sameMatchModel;
            }
          }
          return Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: ScreenUtil.height/20),
                  child: Text(
                    '맞는 상대를 찾았습니다!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    CircularPercentIndicator(
                      radius: ScreenUtil.width/1.95,
                      percent: sameMatchModel.confidence,
                      lineWidth: 10.0,
                      progressColor: primaryBeige,
                    ),
                    Hero(
                      child: GestureDetector(
                        child: CircleAvatar(
                          backgroundImage: AssetImage(sameMatchModel.profileImage),
                          radius: ScreenUtil.width/4.2,
                        ),
                        onTap: () => profileHeroAnimation(
                          context: context,
                          image: sameMatchModel.profileImage
                        ),
                      ),
                      tag: sameMatchModel.profileImage,
                    )
                  ],
                ),
                SizedBox(height: 10.0),
                Text(
                  '${sameMatchModel.nickName}',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0
                  ),
                ),
                SizedBox(height: 10.0),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildTag(sameMatchModel.tagTitle, primaryBlue),
                      SizedBox(width: 10.0),
                      _buildTag(sameMatchModel.tagDetail, primaryGreen)
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildProfileInfo(sameMatchModel.animalName),
                    SizedBox(width: 10.0),
                    _buildProfileInfo(sameMatchModel.emotion),
                    SizedBox(width: 10.0),
                    _buildProfileInfo(sameMatchModel.age+'살'),
                    SizedBox(width: 10.0),
                    _buildProfileInfo(sameMatchModel.gender)
                  ],
                ),
                SizedBox(height: 10.0),
                RaisedButton(
                  color: Color(0xFFff647f),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                  child: Text(
                    '★ 프로필 보기',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  elevation: 5.0,
                  onPressed: () => WidgetsBinding.instance.addPostFrameCallback((_){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => OtherProfileScreen(user:sameMatchModel.userInfo)
                    ));
                  }),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: _getFriendsStream(),
                  builder: (context, snapshot){
                    if(snapshot.hasData && snapshot.data.documents.length>0){
                      return Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          '친구신청 승인 대기중이거나 이미 친구입니다.',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      );
                    }
                    return BlocBuilder(
                      bloc: sameMatchBloc,
                      builder: (context,SameMatchState state){
                        if(state.isRequestLoading) {
                          return CircularProgressIndicator();
                        }
                        if(state.isRequestFailed) {
                          streamSnackbar(context, '친구신청에 실패했습니다.');
                          sameMatchBloc.emitEvent(SameMatchEventStateClear());
                        }
                        return RaisedButton(
                          color: primaryBlue,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                          child: Text(
                            '친구 신청하기',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          elevation: 5.0,
                          onPressed: () => sameMatchBloc
                            .emitEvent(SameMatchEventSendRequest(
                              uid: sameMatchModel.userInfo.documentID)),
                        );
                      }
                    );
                  }
                )
              ],
            ),
          );
        }
      ),
    );
  }
}