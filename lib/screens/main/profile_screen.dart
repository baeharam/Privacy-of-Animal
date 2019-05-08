import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state_builder.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/photo/photo.dart';
import 'package:privacy_of_animal/logics/profile/profile.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/resources/constants.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/screens/sub/profile_fake_part.dart';
import 'package:privacy_of_animal/screens/sub/profile_real_part.dart';
import 'package:privacy_of_animal/screens/sub/profile_tag_part.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/utils/stream_navigator.dart';
import 'package:privacy_of_animal/utils/stream_snackbar.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final CurrentUser _user = sl.get<CurrentUser>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '프로필',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: primaryBlue,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, routeSetting),
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            ProfileFakePart(user: _user),
            Container(
              color: Colors.grey.withOpacity(0.2),
              width: double.infinity,
              height: 10.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtil.width/20,vertical: ScreenUtil.height/20),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          '실제프로필',
                          style: primaryTextStyle,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10.0),
                  ProfileRealPart(title: '이름',detail: _user.realProfileModel.name),
                  ProfileRealPart(title: '성별',detail: _user.realProfileModel.gender),
                  ProfileRealPart(title: '나이',detail: _user.realProfileModel.age),
                  ProfileRealPart(title: '직업',detail: _user.realProfileModel.job)
                ],
              )
            ),
            Container(
              color: Colors.grey.withOpacity(0.2),
              width: double.infinity,
              height: 10.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtil.width/20,vertical: ScreenUtil.height/20),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          '관심사 태그',
                          style: primaryTextStyle,
                        )
                      ),
                      Spacer(),
                      Text(
                        '바꾸고 싶으면 태그를 누르세요.',
                        style: TextStyle(
                          color: primaryBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20.0),
                  ProfileTagPart()
                ],
              )
            ),
            BlocBuilder(
              bloc: sl.get<ProfileBloc>(),
              builder: (context, ProfileState state){
                if(state.isResetImpossible){
                  streamSnackbar(context,state.remainedTime);
                  sl.get<ProfileBloc>().emitEvent(ProfileEventStateClear());
                }
                if(state.isResetPossible){
                  StreamNavigator.pushNamed(context, routePhotoDecision);
                  sl.get<ProfileBloc>().emitEvent(ProfileEventStateClear());
                  sl.get<PhotoBloc>().emitEvent(PhotoEventStateClear());
                }
                return Container();
              },
            )
          ],
        )
      )
    );  
  }
}