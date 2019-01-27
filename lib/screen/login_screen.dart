import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_helpers.dart';
import 'package:privacy_of_animal/logics/login/login.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/resources/constants.dart';
import 'package:privacy_of_animal/utils/stream_snackbar.dart';
import 'package:privacy_of_animal/widgets/arc_background.dart';
import 'package:privacy_of_animal/widgets/login_form.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {

    final loginBloc = MultipleBlocProvider.of<LoginBloc>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ArcBackground(
                backgroundColor: loginBackgroundColor,
                dashColor: loginBackgroundColor,
                title: '로그인',
              ),
              SizedBox(height: ScreenUtil.height/10),    
              LoginForm(),
              BlocEventStateBuilder(
                bloc: loginBloc,
                builder: (context, LoginState state){
                  if(state.isFailed){
                    streamSnackbar(context, '회원가입에 실패했습니다.');
                    loginBloc.emitEvent(LoginEventInitial());
                  }
                  return Container();
                },
              ) 
            ]
          ),
        ),
      ),
    );
  }
}