import 'package:flutter/material.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/resources/constants.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:privacy_of_animal/utils/stream_navigator.dart';
import 'package:privacy_of_animal/widgets/arc_background2.dart';
import 'package:privacy_of_animal/widgets/primary_button.dart';

class AnalyzeResultScreen extends StatefulWidget {
  @override
  _AnalyzeResultScreenState createState() => _AnalyzeResultScreenState();
}

class _AnalyzeResultScreenState extends State<AnalyzeResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          ArcBackground2(),
          Column(
            children: <Widget>[
              SizedBox(height: ScreenUtil.height/10),
              Column(
                children: <Widget>[
                  Text(
                    '당신의 얼굴형은',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: sl.get<CurrentUser>().fakeProfileModel.animalName,
                      style: TextStyle(
                        background: Paint()
                              ..color = primaryGreen,
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold
                      ),
                      children: [
                        TextSpan(
                          text: '를 닮았습니다.',
                          style: TextStyle(
                            color: Colors.black,
                            background: Paint()
                              ..color = Colors.transparent,
                          )
                        )
                      ]
                    ),
                  )
                ],
              ),
              SizedBox(height: ScreenUtil.height/20),
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  CircularPercentIndicator(
                    radius: ScreenUtil.width/1.9,
                    percent: sl.get<CurrentUser>().fakeProfileModel.animalConfidence,
                    lineWidth: 10.0,
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage(sl.get<CurrentUser>().fakeProfileModel.animalImage),
                    radius: ScreenUtil.width/4.2,
                  )
                ],
              ),
              SizedBox(height: ScreenUtil.height/20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ResultText(
                    title: '추정동물',
                    value: sl.get<CurrentUser>().fakeProfileModel.animalName,
                    confidence: (sl.get<CurrentUser>().fakeProfileModel.animalConfidence*100).toStringAsFixed(1),
                  ),
                  SizedBox(height: 10.0),
                  ResultText(
                    title: '추정성별',
                    value: sl.get<CurrentUser>().fakeProfileModel.gender,
                    confidence: (sl.get<CurrentUser>().fakeProfileModel.genderConfidence*100).toStringAsFixed(1),
                  ),
                  SizedBox(height: 10.0),
                  ResultText(
                    title: '추정나이',
                    value: sl.get<CurrentUser>().fakeProfileModel.age,
                    confidence: (sl.get<CurrentUser>().fakeProfileModel.ageConfidence*100).toStringAsFixed(1),
                  ),
                  SizedBox(height: 10.0),
                  ResultText(
                    title: '추정기분',
                    value: sl.get<CurrentUser>().fakeProfileModel.emotion,
                    confidence: (sl.get<CurrentUser>().fakeProfileModel.emotionConfidence*100).toStringAsFixed(1),
                  ),
                  SizedBox(height: 10.0),
                  ResultText(
                    title: '연예인',
                    value: sl.get<CurrentUser>().fakeProfileModel.celebrity,
                    confidence: (sl.get<CurrentUser>().fakeProfileModel.celebrityConfidence*100).toStringAsFixed(1),
                  ),
                  SizedBox(height: ScreenUtil.height/10),
                  PrimaryButton(
                    text: '프로필 확인',
                    color: primaryBeige,
                    callback: () => StreamNavigator.pushNamedAndRemoveAll(context, routeHomeDecision),
                  )
                ],
              )
            ],
          )
        ]
      ),
    );
  }
}

class ResultText extends StatelessWidget {

  final String title;
  final String value;
  final String confidence;

  ResultText({
    @required this.title,
    @required this.value,
    @required this.confidence
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: ScreenUtil.width/6,right: ScreenUtil.width/6),
      child: Row(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold
            )
          ),
          SizedBox(width: ScreenUtil.width/12),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold
              )
            ),
          ),
          Text(
            '$confidence%',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold
            )
          )
        ],
      ),
    );
  }
}