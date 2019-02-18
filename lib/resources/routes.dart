import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:privacy_of_animal/decisions/decision.dart';
import 'package:privacy_of_animal/resources/resources.dart';
import 'package:privacy_of_animal/screens/main/screen.dart';

Map<String, WidgetBuilder> routes =  {
  /// Screen
  routeIntro: (BuildContext context) => IntroScreen(),
  routeLogin: (BuildContext context) => LoginScreen(),
  routeTagSelect: (BuildContext context) => TagSelectScreen(),
  routeTagChat: (BuildContext context) => TagChatScreen(),
  routePhoto: (BuildContext context) => PhotoScreen(),
  routeAnalyzeIntro: (BuildContext context) => AnalyzeIntroScreen(),
  routeRandomLoading: (BuildContext context) => RandomLoadingScreen(),
  routeSameMatch: (BuildContext context) => SameMatchScreen(),

  /// Decision
  routeLoginDecision: (BuildContext context) => LoginDecision(),
  routeSignUpDecision: (BuildContext context) => SignUpDecision(),
  routePhotoDecision: (BuildContext context) => PhotoDecision(),
  routeHomeDecision: (BuildContext context) => HomeDecision()
};