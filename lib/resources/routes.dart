import 'package:flutter/widgets.dart';
import 'package:privacy_of_animal/decision/decision.dart';
import 'package:privacy_of_animal/screen/main/screen.dart';

Map<String, WidgetBuilder> routes =  {
  '/intro': (BuildContext context) => IntroScreen(),
  '/login': (BuildContext context) => LoginScreen(),
  '/loginDecision': (BuildContext context) => LoginDecision(),
  '/signUpDecision': (BuildContext context) => SignUpDecision(),
  '/homeDecision': (BuildContext context) => HomeDecision()
};