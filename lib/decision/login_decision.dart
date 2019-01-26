import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_helpers.dart';
import 'package:privacy_of_animal/logics/authentication/authentication.dart';
import 'package:privacy_of_animal/screen/login_screen.dart';
import 'package:privacy_of_animal/utils/stream_navigator.dart';


class LoginDecision extends StatefulWidget {
  @override
  _LoginDecisionState createState() => _LoginDecisionState();
}

class _LoginDecisionState extends State<LoginDecision> {

  final AuthenticationBloc _bloc = AuthenticationBloc();

  @override
  Widget build(BuildContext context) {
    return BlocEventStateBuilder(
      bloc: _bloc,
      builder: (BuildContext context, AuthenticationState state){
        if(!state.isAuthenticated){
          return BlocProvider<AuthenticationBloc>(
            bloc: _bloc,
            child: LoginScreen()
          );
        }
        if(state.isAuthenticated){
          StreamNavigator.pushReplacementNamed(context, '/homeDecision');
        }
        return Container();
      },
    );
  }
}