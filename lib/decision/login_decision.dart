import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_helpers.dart';
import 'package:privacy_of_animal/logics/authentication/authentication.dart';
import 'package:privacy_of_animal/logics/validation/validation_bloc.dart';
import 'package:privacy_of_animal/screen/login_screen.dart';
import 'package:privacy_of_animal/utils/stream_navigator.dart';


class LoginDecision extends StatefulWidget {
  @override
  _LoginDecisionState createState() => _LoginDecisionState();
}

class _LoginDecisionState extends State<LoginDecision> {

  final List<BlocBase> _blocs = [ValidationBloc(), AuthenticationBloc()];

  @override
  Widget build(BuildContext context) {
    return MultipleBlocProvider(
      blocs: _blocs,
      child: BlocEventStateBuilder(
        bloc: _blocs[1],
        builder: (BuildContext context, AuthenticationState state){
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