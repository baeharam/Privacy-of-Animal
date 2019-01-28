import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_helpers.dart';
import 'package:privacy_of_animal/logics/signup/signup.dart';
import 'package:privacy_of_animal/logics/validation/validation_bloc.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/resources/constants.dart';
import 'package:privacy_of_animal/resources/strings.dart';
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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  @override
    void dispose() {
      _emailController.dispose();
      _passwordController.dispose();
      _emailFocusNode.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {

    final ValidationBloc validationBloc = MultipleBlocProvider.of<ValidationBloc>(context);
    final SignUpBloc signUpBloc = MultipleBlocProvider.of<SignUpBloc>(context);
    int age;

    return Container(
      height: ScreenUtil.height/1.7,
      width: ScreenUtil.width/1.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 5.0),
            child: Text(
              '이메일',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 18.0
              ),
            ),
          ),
          StreamBuilder<String>(
            stream: validationBloc.email,
            initialData: signUpEmptyNameError,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot){
              return EnsureVisibleWhenFocused(
                focusNode: _emailFocusNode,
                child: BlocEventStateBuilder(
                  bloc: signUpBloc,
                  builder: (BuildContext context, SignUpState state){
                    if(state.isFailed){
                      _emailController.clear();
                    }
                    return TextField(
                      decoration: InputDecoration(
                        errorText: snapshot.error,
                        hintText: signUpEmailHint
                      ),
                      onChanged: validationBloc.onEmailChanged,
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                      enabled: state.isRegistering?false:true,
                    );
                  } 
                ),
              );
            },
          ),
          SizedBox(height: ScreenUtil.height/25),
          Padding(
            padding: EdgeInsets.only(bottom: 5.0),
            child: Text(
              '비밀번호',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 18.0
              ),
            ),
          ),
          StreamBuilder<String>(
            stream: validationBloc.password,
            initialData: signUpEmptyAgeError,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot){
              return BlocEventStateBuilder(
                bloc: signUpBloc,
                builder: (BuildContext context, SignUpState state){
                  if(state.isFailed){
                    _passwordController.clear();
                  }
                  return TextField(
                    decoration: InputDecoration(
                      errorText: snapshot.error,
                      hintText: signUpPasswordHint
                    ),
                    onChanged: validationBloc.onPasswordChanged,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    controller: _passwordController,
                    enabled: state.isRegistering?false:true
                  );
                },
              );
            },
          ),
          SizedBox(height: ScreenUtil.height/15),
          FlatButton(
            child: Text('나이'),
            onPressed: () => Picker(
              adapter: PickerDataAdapter<String>(pickerdata: JsonDecoder().convert(AgePickerData)),
              hideHeader: true,
              cancelTextStyle: TextStyle(color: Colors.red),
              confirmTextStyle: TextStyle(color: Colors.red),
              title: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Text('나이를 선택해주세요.',textAlign: TextAlign.center),
              ),
              textAlign: TextAlign.center,
              onConfirm: (Picker picker, List value){
                age = int.parse(picker.getSelectedValues()[1]);
              }
            ).showDialog(context)
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
                      email: _emailController.text, password: _passwordController.text
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