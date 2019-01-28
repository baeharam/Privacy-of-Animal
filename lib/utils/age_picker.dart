import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:privacy_of_animal/logics/signup/signup_bloc.dart';
import 'package:privacy_of_animal/logics/signup/signup_event.dart';
import 'package:privacy_of_animal/logics/validation/validation_bloc.dart';
import 'package:privacy_of_animal/resources/constants.dart';

void showAgePicker(BuildContext context, ValidationBloc validationBloc, SignUpBloc signUpBloc) {
  Picker(
    adapter: PickerDataAdapter<String>(pickerdata: JsonDecoder().convert(agePickerData)),
    hideHeader: true,
    title: Text('나이를 선택해주세요.'),
    onConfirm: (Picker picker, List value)
      {
        int age = int.parse(picker.getSelectedValues()[1]);
        validationBloc.onAgeSelected(age);
        signUpBloc.emitEvent(SignUpEventAgeSelect(age: age));
        FocusScope.of(context).requestFocus(FocusNode());
      }
  ).showDialog(context);
}