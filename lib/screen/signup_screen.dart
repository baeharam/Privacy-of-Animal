import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/multiple_bloc_provider.dart';
import 'package:privacy_of_animal/logics/signup/signup.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/resources/constants.dart';
import 'package:privacy_of_animal/utils/stream_snackbar.dart';
import 'package:privacy_of_animal/widgets/arc_background.dart';
import 'package:privacy_of_animal/widgets/signup_form.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  @override
  Widget build(BuildContext context) {

    final signUpBloc = MultipleBlocProvider.of<SignUpBloc>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ArcBackground(
                backgroundColor: signUpBackgroundColor,
                dashColor: signUpBackgroundColor,
                title: '회원가입',
              ),
              SizedBox(height: ScreenUtil.height/10),
              SignUpForm(),
              StreamBuilder(
                stream: signUpBloc.state,
                builder: (BuildContext context, AsyncSnapshot<SignUpState> snapshot){
                  if(snapshot.hasData && snapshot.data.isFailed){
                    streamSnackbar(context, '회원가입에 실패했습니다.');
                    signUpBloc.emitEvent(SignUpEventInitial());
                  }
                  return Container();
                },
              )
            ]
          ),
        ),
      )
    );
  }
}