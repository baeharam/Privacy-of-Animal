import 'package:flutter/material.dart';
import 'package:privacy_of_animal/logics/validation/validation_bloc.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/resources/constants.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/widgets/focus_visible_maker.dart';
import 'package:privacy_of_animal/widgets/initial_button.dart';

class SignUpProfileForm extends StatefulWidget {
  @override
  _SignUpProfileFormState createState() => _SignUpProfileFormState();
}

class _SignUpProfileFormState extends State<SignUpProfileForm> {

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _ageFocusNode = FocusNode();
  final FocusNode _jobFocusNode = FocusNode();
  final ValidationBloc _validationBloc = ValidationBloc();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();


  @override
    void dispose() {
      _nameController.dispose();
      _ageController.dispose();
      _jobController.dispose();
      _nameFocusNode.dispose();
      _ageFocusNode.dispose();
      _jobFocusNode.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
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
                focusNode: _nameFocusNode,
                focusType: FocusType.EMAIL_FOCUS,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: '이메일',
                    errorText: snapshot.error,
                  ),
                  onChanged: _validationBloc.onEmailChanged,
                  keyboardType: TextInputType.emailAddress,
                  controller: _nameController,
                  focusNode: _nameFocusNode,
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
                focusNode: _ageFocusNode,
                focusType: FocusType.PASSWORD_FOCUS,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: '비밀번호',
                    errorText: snapshot.error
                  ),
                  onChanged: _validationBloc.onPasswordChanged,
                  obscureText: true,
                  keyboardType: TextInputType.emailAddress,
                  controller: _ageController,
                  focusNode: _ageFocusNode,
                ),
              );
            },
          ),
          SizedBox(height: ScreenUtil.height/10),
          StreamBuilder<bool>(
            stream: _validationBloc.loginValid,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
              return InitialButton(
                text: '선택완료',
                color: introLoginButtonColor,
                callback: (snapshot.hasData && snapshot.data==true) ? (){} : null,
              );
            },
          )
        ],
      ),
    );
  }
}