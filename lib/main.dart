import 'package:flutter/material.dart';
import 'package:privacy_of_animal/resources/routes.dart';
import 'package:privacy_of_animal/screen/intro_screen.dart';

void main() {
  runApp(PrivacyOfAnimal());
}

class PrivacyOfAnimal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '동물의 사생활',
      home: IntroScreen(),
      theme: ThemeData(fontFamily: 'NanumGothic'),
      routes: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}

