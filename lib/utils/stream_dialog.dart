import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_helpers.dart';
import 'package:privacy_of_animal/logics/find_password/find_password.dart';
import 'package:privacy_of_animal/logics/validation/validation_bloc.dart';
import 'package:privacy_of_animal/resources/resources.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void streamDialogForgotPassword(BuildContext context) {

  final ValidationBloc validationBloc = MultipleBlocProvider.of<ValidationBloc>(context);
  final FindPasswordBloc findPasswordBloc = MultipleBlocProvider.of<FindPasswordBloc>(context);
  final TextEditingController _emailController = TextEditingController();

  WidgetsBinding.instance.addPostFrameCallback((_){
    Alert(
      context: context,
      title: '비밀번호 찾기',
      content: Column(
        children: <Widget>[
          StreamBuilder<String>(
            stream: validationBloc.email,
            initialData: loginEmptyEmailError,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot){
              return TextField(
                decoration: InputDecoration(
                  labelText: '이메일',
                  errorText: snapshot.error,
                ),
                onChanged: validationBloc.onEmailChanged,
                keyboardType: TextInputType.emailAddress,
                controller: _emailController
              );
            },
          )
        ],
      ),
      desc: findPasswordMessage,
      buttons: [
        DialogButton(
          onPressed: (){
            findPasswordBloc.emitEvent(FindPasswordEventForgotPasswordButton(email: _emailController.text));
            FocusScope.of(context).requestFocus(FocusNode());
            Navigator.pop(context);
          },
          child: Text(
            '확인',
            style: TextStyle(
              color: Colors.white
            ),
          ),
          color: loginBackgroundColor,
        )
      ]
    ).show();
  });
}