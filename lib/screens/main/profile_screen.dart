import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/resources/constants.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  CurrentUser user = sl.get<CurrentUser>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: ScreenUtil.width/1.6,top: ScreenUtil.height/20),
              child: Text(
                '가상프로필',
                style: primaryTextStyle,
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                CircularPercentIndicator(
                  radius: ScreenUtil.width/1.9,
                  percent: user.fakeProfileModel.animalConfidence,
                  lineWidth: 10.0,
                ),
                CircleAvatar(
                  backgroundImage: AssetImage(user.fakeProfileModel.animalImage),
                  radius: ScreenUtil.width/4.2,
                )
              ],
            ),
            SizedBox(height: ScreenUtil.height/30),
            Text(
              user.fakeProfileModel.age+'살 / '+
              user.fakeProfileModel.gender+' / '+
              user.fakeProfileModel.emotion+' / '+
              user.fakeProfileModel.animalName,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: ScreenUtil.height/30),
            Container(
              width: double.infinity,
              height: ScreenUtil.height/15,
              color: primaryBeige,
              alignment: Alignment.center,
              child: Text(
                '실제프로필 : '+
                user.realProfile.age+' / '+
                user.realProfile.gender+' / '+
                user.realProfile.job+' / '+
                user.realProfile.name,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: ScreenUtil.width/1.6,top: ScreenUtil.height/20),
              child: Text(
                '관심사 태그',
                style: primaryTextStyle,
              ),
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    TagForm(content: user.tagListModel.tagTitleList[0]),
                    TagForm(content: user.tagListModel.tagDetailList[0])
                  ],
                )
              ],
            )
          ],
        ),
      )
    );  
  }
}

class TagForm extends StatelessWidget {

  final String content;

  TagForm({
    @required this.content
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0,vertical: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.0),
        border: Border.all(color: primaryGreen)
      ),
      child: Text(
        '# $content'
      ),
    );
  }
}