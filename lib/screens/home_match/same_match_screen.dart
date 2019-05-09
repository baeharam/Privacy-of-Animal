import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state_builder.dart';
import 'package:privacy_of_animal/logics/global/current_user.dart';
import 'package:privacy_of_animal/logics/same_match/same_match.dart';
import 'package:privacy_of_animal/models/same_match_model.dart';
import 'package:privacy_of_animal/resources/resources.dart';
import 'package:privacy_of_animal/screens/other_profile/other_profile_screen.dart';
import 'package:privacy_of_animal/screens/home_match/same_match_sub.dart';
import 'package:privacy_of_animal/utils/profile_hero.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/utils/bloc_snackbar.dart';

class SameMatchScreen extends StatefulWidget {
  @override
  _SameMatchScreenState createState() => _SameMatchScreenState();
}

class _SameMatchScreenState extends State<SameMatchScreen> {

  final SameMatchBloc _sameMatchBloc = sl.get<SameMatchBloc>();
  SameMatchModel _sameMatchModel;

  @override
  void dispose() {
    sl.get<CurrentUser>().currentProfileUID = '';
    _sameMatchBloc.emitEvent(SameMatchEventDisconnectToServer(otherUserUID: _sameMatchModel.userInfo.uid));
    super.dispose();
  }

  void _viewOtherProfile() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => OtherProfileScreen(user:_sameMatchModel.userInfo)
      ));
    });
  }

  bool _isAlreadyFriends() => sl.get<CurrentUser>().friendsList.where((user)
    => user.uid==_sameMatchModel.userInfo.uid
  ).isNotEmpty;
  bool _isAlreadyRequestFrom() => sl.get<CurrentUser>().requestFromList.where((user)
    => user.uid==_sameMatchModel.userInfo.uid
  ).isNotEmpty;
  bool _isAlreadyRequestTo() => sl.get<CurrentUser>().isRequestTo;

  

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
            onPressed: () {
              _sameMatchBloc.emitEvent(SameMatchEventDisconnectToServer(
                otherUserUID: _sameMatchModel.userInfo.uid));
              _sameMatchBloc.emitEvent(SameMatchEventFindUser());
            }
          )
        ],
      ),
      body: BlocBuilder(
        bloc: _sameMatchBloc,
        builder: (context, SameMatchState state){
          if(state.isFindLoading || state.isInitial) {
            return SameMatchLoadingIndicator();
          }
          if(state.isFindFailed){
            return Center(child: Text('데이터를 불러오는데 실패했습니다.'));
          }
          if(state.isFindSucceeded) {
            if(state.sameMatchModel.tagTitle==null){
              return Center(child: Text('아직까지 맞는 상대가 없습니다.'));
            } else {
              _sameMatchModel = state.sameMatchModel;
              _sameMatchBloc.emitEvent(SameMatchEventConnectToServer(
                  otherUserUID: _sameMatchModel.userInfo.uid));
              sl.get<CurrentUser>().currentProfileUID = _sameMatchModel.userInfo.uid;
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
                      percent: _sameMatchModel.confidence,
                      lineWidth: 10.0,
                      progressColor: primaryBeige,
                    ),
                    Hero(
                      child: GestureDetector(
                        child: CircleAvatar(
                          backgroundImage: AssetImage(_sameMatchModel.profileImage),
                          radius: ScreenUtil.width/4.2,
                        ),
                        onTap: () => profileHeroAnimation(
                          context: context,
                          image: _sameMatchModel.profileImage
                        ),
                      ),
                      tag: _sameMatchModel.profileImage,
                    )
                  ],
                ),
                SizedBox(height: 10.0),
                Text(
                  _sameMatchModel.nickName,
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
                      SameMatchTagForm(tagBorderColor: primaryBlue,tagContent: _sameMatchModel.tagTitle),
                      SizedBox(width: 10.0),
                      SameMatchTagForm(tagBorderColor: primaryBlue,tagContent: _sameMatchModel.tagDetail)
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SameMatchFakeProfileForm(content: _sameMatchModel.animalName),
                    SizedBox(width: 10.0),
                    SameMatchFakeProfileForm(content: _sameMatchModel.emotion),
                    SizedBox(width: 10.0),
                    SameMatchFakeProfileForm(content: _sameMatchModel.age+'살'),
                    SizedBox(width: 10.0),
                    SameMatchFakeProfileForm(content: _sameMatchModel.gender)
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SameMatchButton(
                      color: sameMatchRedColor,
                      title: '★ 프로필 보기',
                      onPressed: () {
                        _sameMatchBloc.emitEvent(SameMatchEventEnterOtherProfileScreen());
                        _viewOtherProfile();
                      }
                    ),
                    SizedBox(width: 15.0),
                    BlocBuilder(
                      bloc: _sameMatchBloc,
                      builder: (context,SameMatchState state){  
                        if(_isAlreadyFriends() || _isAlreadyRequestFrom()){
                          return Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Text(
                              _isAlreadyFriends()
                              ? '이미 친구입니다.'
                              : '친구신청을 받았습니다.',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          );
                        }
                        if(state.isRequestLoading || 
                           state.isCancelLoading || 
                           state.isRefreshLoading) {
                          return CircularProgressIndicator();
                        }

                        if(_isAlreadyRequestTo()) {
                          return SameMatchButton(
                            color: primaryGreen,
                            title: '친구 신청취소',
                            onPressed: () => _sameMatchBloc
                            .emitEvent(SameMatchEventCancelRequest(
                              uid: _sameMatchModel.userInfo.uid))
                          );
                        }
                        if(state.isRequestFailed) {
                          BlocSnackbar.show(context, '친구신청에 실패했습니다.');
                          _sameMatchBloc.emitEvent(SameMatchEventStateClear());
                        }
                        return SameMatchButton( 
                          color: primaryBlue,
                          title: '친구 신청하기',
                          onPressed: () => _sameMatchBloc
                            .emitEvent(SameMatchEventSendRequest(
                              uid: _sameMatchModel.userInfo.uid))
                        );
                      }
                    )
                  ]
                )
              ],
            ),
          );
        }
      ),
    );
  }
}