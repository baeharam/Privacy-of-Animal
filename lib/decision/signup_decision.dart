import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_helpers.dart';
import 'package:privacy_of_animal/logics/signup/signup.dart';
import 'package:privacy_of_animal/screen/signup_email_password_screen.dart';
import 'package:privacy_of_animal/screen/signup_profile_screen.dart';
import 'package:privacy_of_animal/utils/stream_navigator.dart';
import 'package:privacy_of_animal/widgets/progress_indicator.dart';


class SignUpDecision extends StatefulWidget {
  @override
  _SignUpDecisionState createState() => _SignUpDecisionState();
}

class _SignUpDecisionState extends State<SignUpDecision> {

  final SignUpBloc _bloc = SignUpBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpBloc>(
      bloc: _bloc,
      child: BlocEventStateBuilder(
        bloc: _bloc,
        builder: (BuildContext context, SignUpState state){

          if(state.isRegisterd){
            StreamNavigator.pushNamedAndRemoveUntil(context, '/login', '/intro');
          }

          if(!state.isProfileCompleted){
            return SignUpProfileScreen();
          }

          List<Widget> widgets = [];

          if(state.isProfileCompleted){
            widgets.add(SignUpEmailPasswordScreen());
          }
          if(state.isRegistering){
            widgets.add(CustomProgressIndicator());
          }

          widgets.add(Container());
          return Column(children: widgets);
        },
      ),
    );
  }
}