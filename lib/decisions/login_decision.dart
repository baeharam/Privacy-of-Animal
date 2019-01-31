import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_helpers.dart';
import 'package:privacy_of_animal/logics/find_password/find_password_bloc.dart';
import 'package:privacy_of_animal/logics/login/login.dart';
import 'package:privacy_of_animal/logics/validation/validation_bloc.dart';
import 'package:privacy_of_animal/models/user_model.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/screens/main/screen.dart';
import 'package:privacy_of_animal/utils/stream_navigator.dart';
import 'package:privacy_of_animal/utils/user_state_provider.dart';


class LoginDecision extends StatefulWidget {
  @override
  _LoginDecisionState createState() => _LoginDecisionState();
}

class _LoginDecisionState extends State<LoginDecision> {

  final ValidationBloc _validationBloc = ValidationBloc();
  final LoginBloc _loginBloc   = LoginBloc();
  final FindPasswordBloc _findPasswordBloc = FindPasswordBloc();

  final User user = User();

  @override
  Widget build(BuildContext context) {
    return UserStateProvider(
      user: user,
      child: BlocBuilder(
        bloc: _loginBloc,
        builder: (BuildContext context, LoginState state){
          if(!state.isAuthenticated){
            return MultipleBlocProvider(
              blocs: [_validationBloc, _loginBloc, _findPasswordBloc],
              child: LoginScreen()
            );
          }
          if(state.isAuthenticated){
            if(!state.isTagSelected){
              StreamNavigator.pushNamedAndRemoveAll(context,routeTagSelect);
            }
            if(state.isTagSelected){
              StreamNavigator.pushNamedAndRemoveAll(context,routeTagChat);
            }
          }
          return Container();
        },
      ),
    );
  }
}