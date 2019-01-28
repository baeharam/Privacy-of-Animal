import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/multiple_bloc_provider.dart';
import 'package:privacy_of_animal/logics/signup/signup.dart';
import 'package:privacy_of_animal/logics/validation/validation_bloc.dart';

class SignUpGenderSelect extends StatefulWidget {

  final String genderTitle;
  final SignUpEvent signUpEvent;
  final bool isSelected;

  SignUpGenderSelect({
    @required this.genderTitle,
    @required this.signUpEvent,
    @required this.isSelected
  });

  @override
  _SignUpGenderSelectState createState() => _SignUpGenderSelectState();
}

class _SignUpGenderSelectState extends State<SignUpGenderSelect> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 8.0),
        decoration: BoxDecoration(
          color: widget.isSelected ? Colors.black : Colors.transparent,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: Colors.black)
        ),
        child: Text(
          widget.genderTitle,
          style: TextStyle(
            color: widget.isSelected ? Colors.white : Colors.black,
            fontSize: 20.0
          ),
        ),
      ),
      onTap: () {
        MultipleBlocProvider.of<SignUpBloc>(context).emitEvent(widget.signUpEvent);
        MultipleBlocProvider.of<ValidationBloc>(context).onGenderSelected(widget.genderTitle);
        FocusScope.of(context).requestFocus(FocusNode());
      }
    );
  }
}