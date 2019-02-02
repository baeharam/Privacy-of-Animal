import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_helpers.dart';
import 'package:privacy_of_animal/logics/login/login.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/screens/main/screen.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/utils/stream_navigator.dart';


class LoginDecision extends StatefulWidget {
  @override
  _LoginDecisionState createState() => _LoginDecisionState();
}

class _LoginDecisionState extends State<LoginDecision> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: sl.get<LoginBloc>(),
      builder: (BuildContext context, LoginState state){
        if(!state.isAuthenticated){
          return LoginScreen();
        }
        if(state.isAuthenticated){
          if(state.isTagSelected){
            StreamNavigator.pushNamedAndRemoveAll(context,routeTagSelect);
          }
          if(state.isTagChatted){
            StreamNavigator.pushNamedAndRemoveAll(context,routeTagChat);
          }
        }
        return Container();
      },
    );
  }
}