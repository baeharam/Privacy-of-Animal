import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_helpers.dart';
import 'package:privacy_of_animal/logics/authentication/authentication.dart';
import 'package:privacy_of_animal/screen/login_screen.dart';


class AuthenticationDecision extends StatefulWidget {
  @override
  _AuthenticationDecisionState createState() => _AuthenticationDecisionState();
}

class _AuthenticationDecisionState extends State<AuthenticationDecision> {

  final AuthenticationBloc _authenticationBloc = AuthenticationBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      bloc: _authenticationBloc,
      child: BlocEventStateBuilder(
        bloc: _authenticationBloc,
        builder: (BuildContext context, AuthenticationState state){
          if(!state.isAuthenticated){
            return LoginScreen();
          }
          return Container();
        },
      ),
    );
  }
}