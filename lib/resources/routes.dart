import 'package:flutter/widgets.dart';
import 'package:privacy_of_animal/decisions/decision.dart';
import 'package:privacy_of_animal/screens/main/screen.dart';

Map<String, WidgetBuilder> routes =  {
  '/intro': (BuildContext context) => IntroScreen(),
  '/login': (BuildContext context) => LoginScreen(),
  '/tagSelect': (BuildContext context) => TagSelectScreen(),
  '/tagChat': (BuildContext context) => TagChatScreen(),

  '/loginDecision': (BuildContext context) => LoginDecision(),
  '/signUpDecision': (BuildContext context) => SignUpDecision(),
};