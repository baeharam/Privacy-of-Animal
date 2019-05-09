import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:privacy_of_animal/logics/global/current_user.dart';
import 'package:privacy_of_animal/logics/profile/profile.dart';
import 'package:privacy_of_animal/resources/resources.dart';
import 'package:privacy_of_animal/utils/profile_hero.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';

class ProfileFakePart extends StatelessWidget {

  final CurrentUser user;

  const ProfileFakePart({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: ScreenUtil.width/20,
        right: ScreenUtil.width/20,
        bottom: ScreenUtil.height/20
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil.height/20),
            child: Row(
              children: <Widget>[
                Text(
                  '가상프로필',
                  style: primaryTextStyle,
                ),
                IconButton(
                  icon: Icon(Icons.update,color: Colors.red),
                  tooltip: '가상 프로필을 갱신할 수 있습니다.',
                  onPressed: () => sl.get<ProfileBloc>().emitEvent(ProfileEventResetFakeProfile())
                ),
                Spacer(),
                GestureDetector(
                  child: Row(
                    children: <Widget>[
                      Text(
                        '닮은 유명인 보기',
                        style: TextStyle(
                          color: primaryBlue,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Icon(Icons.search)
                    ],
                  ),
                  onTap: () => Navigator.push(context, MaterialPageRoute(
                    builder: (context) => 
                      webViewImage(user.fakeProfileModel.celebrity)
                  )),
                )
              ],
            )
          ),
          SizedBox(height: 10.0),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            elevation: 5.0,
            color: primaryGreen,
            child: Padding(
              padding: EdgeInsets.only(left: 10.0,top: 10.0,bottom: 10.0),
              child: Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          CircularPercentIndicator(
                            radius: ScreenUtil.width/2.8,
                            percent: user.fakeProfileModel.animalConfidence,
                            lineWidth: 10.0,
                            progressColor: primaryBeige,
                          ),
                          Hero(
                            child: GestureDetector(
                              child: CircleAvatar(
                                backgroundImage: AssetImage(user.fakeProfileModel.animalImage),
                                radius: ScreenUtil.width/6.2,
                              ),
                              onTap: () => profileHeroAnimation(
                                context: context,
                                image: user.fakeProfileModel.animalImage
                              ),
                            ),
                            tag: user.fakeProfileModel.animalImage,
                          )
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        user.fakeProfileModel.nickName,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                  SizedBox(width: 20.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ProfileFakeElement(title: '추정동물',detail: user.fakeProfileModel.animalName),
                      ProfileFakeElement(title: '추정성별',detail: user.fakeProfileModel.gender),
                      ProfileFakeElement(title: '추정나이',detail: user.fakeProfileModel.age),
                      ProfileFakeElement(title: '추정기분',detail: user.fakeProfileModel.emotion),
                      ProfileFakeElement(title: '유명인   ',detail: user.fakeProfileModel.celebrity)
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}

class ProfileFakeElement extends StatelessWidget {

  final String title;
  final String detail;

  ProfileFakeElement({
    @required this.title,
    @required this.detail
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '$title  ',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20.0
        ),
        children: [TextSpan(
          text: detail,
          style: TextStyle(color: Colors.white)
        )]
      )
    );
  }
}