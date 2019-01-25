import 'package:flutter/widgets.dart';
import 'package:privacy_of_animal/decision/authentication_decision.dart';
import 'package:privacy_of_animal/screen/screen.dart';

Map<String, WidgetBuilder> routes =  {
  '/intro': (BuildContext context) => IntroScreen(),
  '/login': (BuildContext context) => LoginScreen(),
  '/signUp': (BuildContext context) => SignUpProfileScreen(),
  '/decision': (BuildContext context) => AuthenticationDecision()
};