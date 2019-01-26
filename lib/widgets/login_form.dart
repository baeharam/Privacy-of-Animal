import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_provider.dart';
import 'package:privacy_of_animal/logics/authentication/authentication.dart';
import 'package:privacy_of_animal/logics/validation/validation_bloc.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/resources/constants.dart';
import 'package:privacy_of_animal/resources/strings.dart';
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
  final ValidationBloc _validationBloc = ValidationBloc();
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

    final AuthenticationBloc authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);

    return Container(
      height: ScreenUtil.height/2,
      width: ScreenUtil.width/1.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          StreamBuilder<String>(
            stream: _validationBloc.email,
            initialData: loginEmptyEmailError,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot){
              return EnsureVisibleWhenFocused(
                focusNode: _emailFocusNode,
                child: StreamBuilder(
                  stream: authenticationBloc.state,
                  builder: (BuildContext context, AsyncSnapshot<AuthenticationState> state){
                    return TextField(
                      decoration: InputDecoration(
                        labelText: '이메일',
                        errorText: snapshot.error,
                      ),
                      onChanged: _validationBloc.onEmailChanged,
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                      enabled: (state.hasData && state.data.isAuthenticating) ? false : true
                    );
                  } 
                ),
              );
            },
          ),
          SizedBox(height: 20.0),
          StreamBuilder<String>(
            stream: _validationBloc.password,
            initialData: loginEmptyPasswordError,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot){
              return EnsureVisibleWhenFocused(
                focusNode: _passwordFocusNode,
                child: StreamBuilder(
                  stream: authenticationBloc.state,
                  builder: (BuildContext context, AsyncSnapshot<AuthenticationState> state){
                    return TextField(
                      decoration: InputDecoration(
                        labelText: '비밀번호',
                        errorText: snapshot.error
                      ),
                      onChanged: _validationBloc.onPasswordChanged,
                      obscureText: true,
                      keyboardType: TextInputType.emailAddress,
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      enabled: (state.hasData && state.data.isAuthenticating) ? false : true,
                    );
                  } 
                ),
              );
            }
          ),
          SizedBox(height: ScreenUtil.height/10),
          StreamBuilder<bool>(
            stream: _validationBloc.loginValid,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
              return InitialButton(
                text: '로그인',
                color: introLoginButtonColor,
                callback: (snapshot.hasData && snapshot.data==true) 
                ? (){
                  FocusScope.of(context).requestFocus(FocusNode());
                  authenticationBloc.emitEvent(AuthenticationEventLogin(email: _emailController.text, password: _passwordController.text));
                } 
                : null,
              );
            },
          ),
          StreamBuilder<AuthenticationState>(
            stream: authenticationBloc.state,
            builder: (BuildContext context, AsyncSnapshot<AuthenticationState> snapshot){
              if(snapshot.hasData && snapshot.data.isAuthenticating){
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