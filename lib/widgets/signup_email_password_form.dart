import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/multiple_bloc_provider.dart';
import 'package:privacy_of_animal/logics/signup/signup.dart';
import 'package:privacy_of_animal/logics/validation/validation_bloc.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/resources/constants.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/widgets/focus_visible_maker.dart';
import 'package:privacy_of_animal/widgets/initial_button.dart';
import 'package:privacy_of_animal/widgets/progress_indicator.dart';

class SignUpEmailPasswordForm extends StatefulWidget {
  @override
  _SignUpEmailPasswordFormState createState() => _SignUpEmailPasswordFormState();
}

class _SignUpEmailPasswordFormState extends State<SignUpEmailPasswordForm> {

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
                child: StreamBuilder(
                  stream: signUpBloc.state,
                  builder: (BuildContext context, AsyncSnapshot<SignUpState> state){
                    return TextField(
                      decoration: InputDecoration(
                        errorText: snapshot.error,
                        hintText: signUpEmailHint
                      ),
                      onChanged: validationBloc.onEmailChanged,
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                      enabled: (state.hasData && state.data.isEmailPasswordRegistering)?false:true,
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
              return StreamBuilder(
                stream: signUpBloc.state,
                builder: (BuildContext context, AsyncSnapshot<SignUpState> state){
                  return TextField(
                    decoration: InputDecoration(
                      errorText: snapshot.error,
                      hintText: signUpPasswordHint
                    ),
                    onChanged: validationBloc.onPasswordChanged,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    controller: _passwordController,
                    enabled: (state.hasData && state.data.isEmailPasswordRegistering)?false:true
                  );
                },
              );
            },
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
                    SignUpEventEmailPasswordComplete(
                      email: _emailController.text, password: _passwordController.text
                    )
                  );
                } 
                : null,
              );
            },
          ),
          StreamBuilder<SignUpState>(
            stream: signUpBloc.state,
            builder: (BuildContext context, AsyncSnapshot<SignUpState> snapshot){
              if(snapshot.hasData && snapshot.data.isEmailPasswordRegistering){
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