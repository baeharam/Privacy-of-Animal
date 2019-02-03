import 'package:flutter/material.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';

class AnalyzeResultScreen extends StatefulWidget {
  @override
  _AnalyzeResultScreenState createState() => _AnalyzeResultScreenState();
}

class _AnalyzeResultScreenState extends State<AnalyzeResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            FittedBox(
              child: Image.asset(sl.get<CurrentUser>().fakeProfileModel.animalImage),
              fit: BoxFit.contain,
            ),
            Text(sl.get<CurrentUser>().fakeProfileModel.animalName),
            Text(sl.get<CurrentUser>().fakeProfileModel.animalConfidence.toString())
          ],
        ),
      ),
    );
  }
}