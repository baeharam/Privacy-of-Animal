import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state_builder.dart';
import 'package:privacy_of_animal/logics/signup/signup_bloc.dart';
import 'package:privacy_of_animal/logics/signup/signup_state.dart';
import 'package:privacy_of_animal/widgets/focus_visible_maker.dart';

class SignUpInput extends StatefulWidget {

  final String hintText;
  final Stream stream;
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function onChanged;
  final SignUpBloc signUpBloc;
  final TextInputType textInputType;
  final bool obscureText;

  SignUpInput({
    @required this.hintText,
    @required this.stream,
    @required this.controller,
    @required this.focusNode,
    @required this.onChanged,
    @required this.signUpBloc,
    @required this.textInputType,
    this.obscureText: false
  });

  @override
  _SignUpInputState createState() => _SignUpInputState();
}

class _SignUpInputState extends State<SignUpInput> {
  @override
  Widget build(BuildContext context) {
    return EnsureVisibleWhenFocused(
      focusNode: widget.focusNode,
      child: BlocBuilder(
        bloc: widget.signUpBloc,
        builder: (BuildContext context, SignUpState state){
          if(state.isAccountRegisterFailed || state.isProfileRegisterFailed){
            widget.controller.clear();
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
      ),
    );
  }
}