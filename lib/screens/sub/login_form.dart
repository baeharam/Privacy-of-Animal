import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_helpers.dart';
import 'package:privacy_of_animal/logics/find_password/find_password.dart';
import 'package:privacy_of_animal/logics/login/login.dart';
import 'package:privacy_of_animal/logics/validation/validation_bloc.dart';
import 'package:privacy_of_animal/resources/resources.dart';
import 'package:privacy_of_animal/widgets/focus_visible_maker.dart';
import 'package:privacy_of_animal/widgets/initial_button.dart';
import 'package:privacy_of_animal/widgets/progress_indicator.dart';

class LoginForm extends StatefulWidget {

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
    void dispose() {
      _emailController.dispose();
      _passwordController.dispose();
      _emailFocusNode.dispose();
      _passwordFocusNode.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {

    final ValidationBloc validationBloc = MultipleBlocProvider.of<ValidationBloc>(context);
    final FindPasswordBloc findPasswordBloc = MultipleBlocProvider.of<FindPasswordBloc>(context);
    final LoginBloc loginBloc = MultipleBlocProvider.of<LoginBloc>(context);

    return Container(
      height: ScreenUtil.height/1.7,
      width: ScreenUtil.width/1.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          StreamBuilder<String>(
            stream: validationBloc.email,
            initialData: loginEmptyEmailError,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot){
              return BlocBuilder(
                bloc: loginBloc,
                builder: (BuildContext context, LoginState state){
                  if(state.isAuthenticationFailed){
                    _emailController.clear();
                  }
                  return EnsureVisibleWhenFocused(
                    focusNode: _emailFocusNode,
                    curve: Curves.easeOut,
                    duration: const Duration(milliseconds: 200),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: '이메일',
                        errorText: snapshot.error,
                      ),
                      onChanged: validationBloc.onEmailChanged,
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                      enabled: state.isAuthenticating ? false : true
                    ),
                  );
                } 
              );
            },
          ),
          SizedBox(height: 20.0),
          StreamBuilder<String>(
            stream: validationBloc.password,
            initialData: loginEmptyPasswordError,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot){
              return BlocBuilder(
                bloc: loginBloc,
                builder: (BuildContext context, LoginState state){
                  if(state.isAuthenticationFailed){
                    _passwordController.clear();
                  }
                  return EnsureVisibleWhenFocused(
                    focusNode: _passwordFocusNode,
                    curve: Curves.easeOut,
                    duration: const Duration(milliseconds: 200),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: '비밀번호',
                        errorText: snapshot.error
                      ),
                      onChanged: validationBloc.onPasswordChanged,
                      obscureText: true,
                      keyboardType: TextInputType.emailAddress,
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      enabled: state.isAuthenticating ? false : true,
                    ),
                  );
                } 
              );
            }
          ),
          GestureDetector(
            child: Container(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                '비밀번호를 잊으셨습니까?',
                style: TextStyle(
                  fontSize: 13.0
                ),
              ),
            ),
            onTap: () => loginBloc.emitEvent(LoginEventForgotPasswordDialog()),
          ),
          SizedBox(height: ScreenUtil.height/10),
          StreamBuilder<bool>(
            stream: validationBloc.loginValid,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
              return InitialButton(
                text: '로그인',
                color: primaryBeige,
                callback: (snapshot.hasData && snapshot.data==true) 
                ? (){
                  FocusScope.of(context).requestFocus(FocusNode());
                  loginBloc.emitEvent(LoginEventLogin(email: _emailController.text, password: _passwordController.text));
                } 
                : null,
              );
            },
          ),
          SizedBox(height: ScreenUtil.height/10),
          BlocBuilder(
            bloc: loginBloc,
            builder: (context, LoginState state){
              if(state.isAuthenticating){
                return CustomProgressIndicator();
              }
              return Container();
            },
          ),
          BlocBuilder(
            bloc: findPasswordBloc,
            builder: (context, FindPasswordState state){
              if(state.isEmailSending){
                return CustomProgressIndicator();
              }
              return Container();
            }
          )
        ],
      ),
    );
  }
}