import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_helpers.dart';
import 'package:privacy_of_animal/logics/find_password/find_password.dart';
import 'package:privacy_of_animal/logics/login/login.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/resources/constants.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/screens/login/login_form.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/utils/stream_dialog.dart';
import 'package:privacy_of_animal/utils/bloc_snackbar.dart';
import 'package:privacy_of_animal/widgets/arc_background.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {

    final LoginBloc loginBloc = sl<LoginBloc>();
    final FindPasswordBloc findPasswordBloc = sl<FindPasswordBloc>();

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ArcBackground(
                backgroundColor: primaryGreen,
                dashColor: primaryGreen,
                title: '로그인',
              ),
              SizedBox(height: ScreenUtil.height/10),    
              LoginForm(),
              BlocBuilder(
                bloc: loginBloc,
                builder: (context, LoginState state){
                  if(state.isAuthenticationFailed){
                    BlocSnackbar.show(context, loginError);
                    loginBloc.emitEvent(LoginEventStateClear());
                  }
                  if(state.isDialogOpenedForPassword){
                    streamDialogForgotPassword(context);
                    loginBloc.emitEvent(LoginEventStateClear());
                  }
                  return Container();
                },
              ),
              BlocBuilder(
                bloc: findPasswordBloc,
                builder: (context, FindPasswordState state){
                  if(state.isEmailSendFailed){
                    BlocSnackbar.show(context, loginEmailSendError);
                    findPasswordBloc.emitEvent(FindPasswordEventInitial());
                  }
                  if(state.isEmailSendSucceeded){
                    BlocSnackbar.show(context, loginEmailSendSuccess);
                    findPasswordBloc.emitEvent(FindPasswordEventInitial());
                  }
                  return Container();
                },
              ) 
            ]
          ),
        ),
    );
  }
}