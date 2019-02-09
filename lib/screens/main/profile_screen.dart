import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/resources/constants.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Text('가상프로필'),
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
        ],
      )
    );  
  }
}