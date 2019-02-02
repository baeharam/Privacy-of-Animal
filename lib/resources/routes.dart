import 'package:flutter/widgets.dart';
import 'package:privacy_of_animal/decisions/decision.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/screens/main/screen.dart';

Map<String, WidgetBuilder> routes =  {
  /// Screen
  routeIntro: (BuildContext context) => IntroScreen(),
  routeLogin: (BuildContext context) => LoginScreen(),
  routeTagSelect: (BuildContext context) => TagSelectScreen(),
  routeTagChat: (BuildContext context) => TagChatScreen(),
  routePhoto: (BuildContext context) => PhotoScreen(),

  /// Decision
  routeLoginDecision: (BuildContext context) => LoginDecision(),
  routeSignUpDecision: (BuildContext context) => SignUpDecision(),
  routePhotoDecision: (BuildContext context) => PhotoDecision()
};