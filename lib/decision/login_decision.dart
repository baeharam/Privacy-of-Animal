import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_helpers.dart';
import 'package:privacy_of_animal/logics/authentication/authentication.dart';
import 'package:privacy_of_animal/screen/login_screen.dart';
import 'package:privacy_of_animal/widgets/progress_indicator.dart';


class LoginDecision extends StatefulWidget {
  @override
  _LoginDecisionState createState() => _LoginDecisionState();
}

class _LoginDecisionState extends State<LoginDecision> {

  final AuthenticationBloc _authenticationBloc = AuthenticationBloc();

  @override
  Widget build(BuildContext context) {
    return BlocEventStateBuilder(
      bloc: _authenticationBloc,
      builder: (BuildContext context, AuthenticationState state){
        List<Widget> widgets = [];

        if(!state.isAuthenticated){
          widgets.add(LoginScreen());
        }
        if(state.isAuthenticating){
          widgets.add(CustomProgressIndicator());
        }

        widgets.add(Container());
        return Column(children: widgets);
      },
    );
  }
}