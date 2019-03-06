import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_helpers.dart';
import 'package:privacy_of_animal/logics/signup/signup.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/screens/main/signup_screen.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/utils/stream_navigator.dart';


class SignUpDecision extends StatefulWidget {
  @override
  _SignUpDecisionState createState() => _SignUpDecisionState();
}

class _SignUpDecisionState extends State<SignUpDecision> {


  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: sl.get<SignUpBloc>(),
      builder: (BuildContext context, SignUpState state){
        if(state.isRegistered){
          StreamNavigator.pushReplacementNamed(context, routeLoginDecision);
          sl.get<SignUpBloc>().emitEvent(SignUpEventStateClear());
        }
        return SignUpScreen();
      },
    );
  }
}