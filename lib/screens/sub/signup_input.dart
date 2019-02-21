import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state_builder.dart';
import 'package:privacy_of_animal/logics/signup/signup.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';

class SignUpInput extends StatefulWidget {

  final String hintText;
  final Stream stream;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode failFocusNode;
  final Function onChanged;
  final TextInputType textInputType;
  final FOCUS_TYPE type;
  final bool obscureText;

  SignUpInput({
    @required this.hintText,
    @required this.stream,
    @required this.controller,
    @required this.focusNode,
    @required this.failFocusNode,
    @required this.onChanged,
    @required this.textInputType,
    @required this.type,
    this.obscureText: false
  });

  @override
  _SignUpInputState createState() => _SignUpInputState();
}

class _SignUpInputState extends State<SignUpInput> {
  @override
  Widget build(BuildContext context) {

    final SignUpBloc signUpBloc = sl.get<SignUpBloc>();

    return BlocBuilder(
      bloc: signUpBloc,
      builder: (BuildContext context, SignUpState state){
        if(state.isAccountRegisterFailed || state.isProfileRegisterFailed){
          widget.controller.clear();
        }
        if((state.isAccountRegisterFailed && widget.type==FOCUS_TYPE.ACCOUNT_FOCUS) ||
           (state.isProfileRegisterFailed && widget.type==FOCUS_TYPE.PROFILE_FOCUS)){
          FocusScope.of(context).requestFocus(widget.failFocusNode);
        }
        return StreamBuilder<String>(
          stream: widget.stream,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot){
            return TextField(
              decoration: InputDecoration(
                errorText: snapshot.error,
                hintText: widget.hintText
              ),
              onChanged: widget.onChanged,
              keyboardType: TextInputType.emailAddress,
              controller: widget.controller,
              focusNode: widget.focusNode,
              enabled: state.isRegistering?false:true,
              obscureText: widget.obscureText,
            );
          }
        );
      } 
    );
  }
}

enum FOCUS_TYPE {
  ACCOUNT_FOCUS,
  PROFILE_FOCUS
}