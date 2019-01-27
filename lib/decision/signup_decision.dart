import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_helpers.dart';
import 'package:privacy_of_animal/logics/signup/signup.dart';
import 'package:privacy_of_animal/logics/validation/validation_bloc.dart';
import 'package:privacy_of_animal/screen/signup_screen.dart';
import 'package:privacy_of_animal/utils/stream_navigator.dart';


class SignUpDecision extends StatefulWidget {
  @override
  _SignUpDecisionState createState() => _SignUpDecisionState();
}

class _SignUpDecisionState extends State<SignUpDecision> {

  final ValidationBloc _validationBloc = ValidationBloc();
  final SignUpBloc _signUpBloc = SignUpBloc();

  @override
  Widget build(BuildContext context) {
    return MultipleBlocProvider(
      blocs: [_validationBloc, _signUpBloc],
      child: BlocEventStateBuilder(
        bloc: _signUpBloc,
        builder: (BuildContext context, SignUpState state){
          if(state.isRegistered){
            StreamNavigator.pushReplacementNamed(context, '/loginDecision');
          }
          if(!state.isRegistered){
            return SignUpScreen();
          }
          return Container();
        },
      ),
    );
  }
}