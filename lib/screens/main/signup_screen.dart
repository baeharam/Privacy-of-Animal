import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_helpers.dart';
import 'package:privacy_of_animal/logics/signup/signup.dart';
import 'package:privacy_of_animal/logics/validation/validation_bloc.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/resources/constants.dart';
import 'package:privacy_of_animal/screens/sub/signup_form.dart';
import 'package:privacy_of_animal/utils/stream_snackbar.dart';
import 'package:privacy_of_animal/widgets/arc_background.dart';
import 'package:privacy_of_animal/widgets/progress_indicator.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  @override
  Widget build(BuildContext context) {

    final ValidationBloc validationBloc = MultipleBlocProvider.of<ValidationBloc>(context);
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
              SizedBox(height: ScreenUtil.height/20),
              BlocEventStateBuilder(
                bloc: signUpBloc,
                builder: (context, SignUpState state){
                  List<Widget> widgets = [SignUpForm()];
                  if(state.isRegistering){
                    widgets.add(
                      Positioned(
                        bottom: ScreenUtil.height/13,
                        child: CustomProgressIndicator(),
                      )
                    );
                  }
                  return Stack(
                    alignment: Alignment.center,
                    children: widgets
                  );
                }
              ),
              BlocEventStateBuilder(
                bloc: signUpBloc,
                builder: (context, SignUpState state){
                  if(state.isAccountRegisterFailed){
                    streamSnackbar(context, '계정 등록에 실패했습니다.');
                    signUpBloc.emitEvent(SignUpEventInitial());
                    validationBloc.onEmailChanged('');
                  }
                  if(state.isProfileRegisterFailed){
                    streamSnackbar(context, '프로필 등록에 실패했습니다.');
                    signUpBloc.emitEvent(SignUpEventInitial());
                    validationBloc.onNameChanged('');
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