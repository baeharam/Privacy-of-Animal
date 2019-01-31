import 'package:flutter/widgets.dart';
import 'package:privacy_of_animal/decisions/decision.dart';
import 'package:privacy_of_animal/screens/main/screen.dart';

Map<String, WidgetBuilder> routes =  {
  '/intro': (BuildContext context) => IntroScreen(),
  '/login': (BuildContext context) => LoginScreen(),
  '/tag': (BuildContext context) => TagScreen(),
  '/loginDecision': (BuildContext context) => LoginDecision(),
  '/signUpDecision': (BuildContext context) => SignUpDecision(),
  '/homeDecision': (BuildContext context) => HomeDecision(),
  '/photo': (BuildContext context) => PhotoScreen()
};