import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_helpers.dart';
import 'package:privacy_of_animal/logics/find_password/find_password_bloc.dart';
import 'package:privacy_of_animal/logics/login/login.dart';
import 'package:privacy_of_animal/logics/validation/validation_bloc.dart';
import 'package:privacy_of_animal/screen/main/login_screen.dart';
import 'package:privacy_of_animal/utils/stream_navigator.dart';


class LoginDecision extends StatefulWidget {
  @override
  _LoginDecisionState createState() => _LoginDecisionState();
}

class _LoginDecisionState extends State<LoginDecision> {

  final ValidationBloc _validationBloc = ValidationBloc();
  final LoginBloc _loginBloc   = LoginBloc();
  final FindPasswordBloc _findPasswordBloc = FindPasswordBloc();

  @override
  Widget build(BuildContext context) {
    return MultipleBlocProvider(
      blocs: [_validationBloc, _loginBloc, _findPasswordBloc],
      child: BlocEventStateBuilder(
        bloc: _loginBloc,
        builder: (BuildContext context, LoginState state){
          if(!state.isAuthenticated){
            return LoginScreen();
          }
          if(state.isAuthenticated){
            StreamNavigator.pushReplacementNamed(context, '/homeDecision');
          }
          return Container();
        },
      ),
    );
  }
}