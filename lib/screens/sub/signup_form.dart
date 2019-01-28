import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_helpers.dart';
import 'package:privacy_of_animal/logics/signup/signup.dart';
import 'package:privacy_of_animal/logics/validation/validation_bloc.dart';
import 'package:privacy_of_animal/models/signup_model.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/resources/constants.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/screens/sub/signup_input.dart';
import 'package:privacy_of_animal/utils/age_picker.dart';
import 'package:privacy_of_animal/widgets/focus_visible_maker.dart';
import 'package:privacy_of_animal/widgets/initial_button.dart';
import 'package:privacy_of_animal/widgets/progress_indicator.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _jobFocusNode = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();


  @override
    void dispose() {
      _emailController.dispose();
      _passwordController.dispose();
      _nameController.dispose();
      _ageController.dispose();
      _emailFocusNode.dispose();
      _passwordFocusNode.dispose();
      _nameFocusNode.dispose();
      _jobFocusNode.dispose();
      super.dispose();
    }

  Widget _buildTitle(String title){
    return Padding(
      padding: EdgeInsets.only(bottom: 5.0),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 18.0
        ),
      ),
    );
  }

  Widget _buildIntroduction(String introduction, EdgeInsets padding){
    return Padding(
      padding: padding,
      child: Text(
        introduction,
        style: TextStyle(
          color: signUpBackgroundColor,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final ValidationBloc validationBloc = MultipleBlocProvider.of<ValidationBloc>(context);
    final SignUpBloc signUpBloc = MultipleBlocProvider.of<SignUpBloc>(context);

    return Container(
      height: ScreenUtil.height,
      width: ScreenUtil.width/1.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildIntroduction('계정을 입력해주세요.', EdgeInsets.only(bottom: 20.0)),
          _buildTitle('이메일'),
          SignUpInput(
            hintText: signUpEmailHint,
            stream: validationBloc.email,
            controller: _emailController,
            focusNode: _emailFocusNode,
            onChanged: validationBloc.onEmailChanged,
            signUpBloc: signUpBloc,
            textInputType: TextInputType.emailAddress,
          ),
          SizedBox(height: ScreenUtil.height/25),
          _buildTitle('비밀번호'),
          SignUpInput(
            hintText: signUpPasswordHint,
            stream: validationBloc.password,
            controller: _passwordController,
            focusNode: _passwordFocusNode,
            onChanged: validationBloc.onPasswordChanged,
            signUpBloc: signUpBloc,
            textInputType: TextInputType.text,
            obscureText: true,
          ),
          SizedBox(height: ScreenUtil.height/25),
          _buildIntroduction('프로필을 입력해주세요.', EdgeInsets.symmetric(vertical: 20.0)),
          _buildTitle('이름'),
          SignUpInput(
            hintText: signUpNameHint,
            stream: validationBloc.name,
            controller: _nameController,
            focusNode: _nameFocusNode,
            onChanged: validationBloc.onNameChanged,
            signUpBloc: signUpBloc,
            textInputType: TextInputType.text
          ),
          SizedBox(height: ScreenUtil.height/25),
          _buildTitle('나이'),
          BlocEventStateBuilder(
            bloc: signUpBloc,
            builder: (BuildContext context, SignUpState state){
              if(state.isAgeSelected){
                _ageController.text = state.age.toString() + '살';
              }
              return GestureDetector(
                child: Container(
                  color: Colors.transparent,
                  child: IgnorePointer(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: signUpAgeHint
                      ),
                      controller: _ageController,
                    ),
                  ),
                ),
                onTap: () => showAgePicker(context, validationBloc, signUpBloc),
              );
            },
          ),
          SizedBox(height: ScreenUtil.height/25),
          _buildTitle('직업'),
          SignUpInput(
            hintText: signUpJobHint,
            stream: validationBloc.job,
            controller: _jobController,
            focusNode: _jobFocusNode,
            onChanged: validationBloc.onJobChanged,
            signUpBloc: signUpBloc,
            textInputType: TextInputType.text
          ),
          SizedBox(height: ScreenUtil.height/15),
          StreamBuilder<bool>(
            stream: validationBloc.loginValid,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
              return InitialButton(
                text: '회원가입',
                color: introLoginButtonColor,
                callback: (snapshot.hasData && snapshot.data==true) 
                ? (){
                  FocusScope.of(context).requestFocus(FocusNode());
                  signUpBloc.emitEvent(
                    SignUpEventComplete(
                      data: SignUpModel(
                        email: _emailController.text,
                        password: _passwordController.text,

                      )
                    )
                  );
                } 
                : null,
              );
            },
          ),
          SizedBox(height: ScreenUtil.height/10),
          StreamBuilder<SignUpState>(
            stream: signUpBloc.state,
            builder: (BuildContext context, AsyncSnapshot<SignUpState> snapshot){
              if(snapshot.hasData && snapshot.data.isRegistering){
                return CustomProgressIndicator();
              }
              return Container();
            },
          )
        ],
      ),
    );
  }
}