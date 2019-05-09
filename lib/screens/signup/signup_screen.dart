import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_helpers.dart';
import 'package:privacy_of_animal/logics/signup/signup.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/resources/constants.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/screens/signup/signup_form.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/utils/stream_dialog.dart';
import 'package:privacy_of_animal/widgets/arc_background.dart';
import 'package:privacy_of_animal/widgets/modal_popup.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {


  @override
  Widget build(BuildContext context) {

    final signUpBloc = sl.get<SignUpBloc>();

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ArcBackground(
                backgroundColor: primaryPink,
                dashColor: primaryPink,
                title: '회원가입',
              ),
              SizedBox(height: ScreenUtil.height/20),
              BlocBuilder(
                bloc: signUpBloc,
                builder: (context, SignUpState state){
                  List<Widget> widgets = [SignUpForm()];
                  if(state.isRegistering){
                    widgets.add(ModalProgress());
                  }
                  return Stack(
                    alignment: Alignment.center,
                    children: widgets
                  );
                }
              ),
              BlocBuilder(
                bloc: signUpBloc,
                builder: (context, SignUpState state){
                  if(state.isAccountRegisterFailed){
                    streamDialogSignUpFailed(context,signUpAccountFailedTitle,signUpAccountFailedMessage,FAIL_TYPE.ACCOUNT_FAIL);
                    signUpBloc.emitEvent(SignUpEventStateClear());
                  }
                  if(state.isProfileRegisterFailed){
                    streamDialogSignUpFailed(context,signUpProfileFailedTitle,signUpProfileFailedMessage,FAIL_TYPE.PROFILE_FAIL);
                    signUpBloc.emitEvent(SignUpEventStateClear());
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