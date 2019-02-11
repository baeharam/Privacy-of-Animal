import 'package:flutter/material.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/resources/constants.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/widgets/primary_button.dart';

class AnalyzeIntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.warning,
              size: ScreenUtil.width/4,
              color: Colors.red,
            ),
            SizedBox(height: 20.0),
            Text(
              '이제 가상프로필을 만들기 위해서\n'
              '얼굴분석을 시작하겠습니다.\n\n'
              '얼굴분석에 이용되는 기술은 완벽하지 않기 때문에\n'
              '납득되지 않는 결과가 나올 수 있습니다.\n',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15.0
              ),
            ),
            Text(
              '단순한 재미요소로 받아들여주시면 감사하겠습니다.\n',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 15.0
              ),
            ),
            Text(
              '얼굴분석을 하고 나면 아래와 같은 결과가 나옵니다.\n',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15.0
              ),
            ),
            Text(
              '닮은 동물, 추정성별, 추정나이\n추정기분, 닮은 유명인\n',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: primaryGreen,
                fontWeight: FontWeight.bold,
                fontSize: 20.0
              ),
            ),
            Text(
              '이 데이터들이 가상 프로필을 이루며\n'
              '가상 프로필을 통해 채팅을 하게 됩니다.\n\n'
              '그럼, 즐거운 채팅 하세요!\n',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15.0
              )
            ),
            SizedBox(height: 20.0),
            PrimaryButton(
              text: '유념하고 분석하러 가기',
              color: primaryBeige,
              callback: () => Navigator.pushReplacementNamed(context, routePhotoDecision),
            )
          ],
        ),
      ),
    );
  }
}