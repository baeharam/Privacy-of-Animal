import 'package:flutter/foundation.dart';
import 'package:privacy_of_animal/models/intro_page_model.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/resources/strings.dart';

const double dashedCircleRadius = 57.0;
final double dashedBackgroundCircleDiameter = dashedCircleRadius*2+30.0;

class ScreenUtil {
  static double width;
  static double height;
}

class CurrentPlatform {
  static TargetPlatform platform;
}

const pages = [
  const IntroPageModel(
    backgroundColor: introBackgroundColor1,
    image: 'assets/images/animals/lion.jpg',
    aboveMessage: introMessage1Above,
    belowMessage: introMessage1Below,
  ),

  IntroPageModel(
    backgroundColor: introBackgroundColor2,
    image: 'assets/images/animals/bison.jpg',
    aboveMessage: introMessage2Above,
    belowMessage: introMessage2Below,
  ),
  IntroPageModel(
    backgroundColor: introBackgroundColor3,
    image: 'assets/images/animals/tiger.jpg',
    aboveMessage: introMessage3Above,
    belowMessage: introMessage3Below,
  )
];