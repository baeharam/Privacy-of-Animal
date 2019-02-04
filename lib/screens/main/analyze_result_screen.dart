import 'package:flutter/material.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/resources/constants.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:privacy_of_animal/widgets/arc_background2.dart';

class AnalyzeResultScreen extends StatefulWidget {
  @override
  _AnalyzeResultScreenState createState() => _AnalyzeResultScreenState();
}

class _AnalyzeResultScreenState extends State<AnalyzeResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            left: ScreenUtil.width/6,
            top: ScreenUtil.height/10,
            child: RichText(
              text: TextSpan(
                text: '분석한 결과 당신은 ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
                ),
                children: [
                  TextSpan(
                    text: sl.get<CurrentUser>().fakeProfileModel.animalName,
                    style: TextStyle(
                      background: Paint()
                        ..color = primaryGreen ,
                      color: Colors.white
                    )
                  ),
                  TextSpan(text: ' 입니다.')
                ]
              ),
            ),
          ),
          ArcBackground2(),
          Positioned(
            left: ScreenUtil.width/2-ScreenUtil.width/3.8,
            top: ScreenUtil.height/7,
            child: CircularPercentIndicator(
              radius: ScreenUtil.width/1.9,
              percent: sl.get<CurrentUser>().fakeProfileModel.animalConfidence/100.0,
              lineWidth: 10.0,
            ),
          ),
          Positioned(
            left: ScreenUtil.width/2-ScreenUtil.width/4.2,
            top: ScreenUtil.height/6.2,
            child: CircleAvatar(
              backgroundImage: AssetImage(sl.get<CurrentUser>().fakeProfileModel.animalImage),
              radius: ScreenUtil.width/4.2,
            ),
          ),
          Positioned(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                  ],
                )
              ],
            ),
          )
        ]
      ),
    );
  }
}