import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_helpers.dart';
import 'package:privacy_of_animal/logics/authentication/authentication.dart';
import 'package:privacy_of_animal/logics/validation/validation_bloc.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/resources/constants.dart';
import 'package:privacy_of_animal/widgets/arc_background.dart';
import 'package:privacy_of_animal/widgets/signup_profile_form.dart';

class SignUpProfileScreen extends StatefulWidget {
  @override
  _SignUpProfileScreenState createState() => _SignUpProfileScreenState();
}

class _SignUpProfileScreenState extends State<SignUpProfileScreen> {

  @override
    void initState() {
      super.initState();
    }

  @override
  Widget build(BuildContext context) {

    final AuthenticationBloc bloc = BlocProvider.of<AuthenticationBloc>(context);

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
              Container(
                padding: EdgeInsets.only(
                  left: ScreenUtil.height/15,right: ScreenUtil.height/15,top: ScreenUtil.height/50,bottom: ScreenUtil.height/30),
                child: Text(
                  '프로필을 기입해주세요.',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0
                  ),
                )
              ),    
              BlocProvider<ValidationBloc>(
                bloc: ValidationBloc(),
                child: SignUpProfileForm()
              )    
            ]
          ),
        ),
      ),
    );
  }
}