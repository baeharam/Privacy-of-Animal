import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:privacy_of_animal/logics/signup/signup_bloc.dart';
import 'package:privacy_of_animal/logics/signup/signup_event.dart';
import 'package:privacy_of_animal/logics/validation/validation_bloc.dart';
import 'package:privacy_of_animal/resources/constants.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';

void showAgePicker(BuildContext context) {
  Picker(
    adapter: PickerDataAdapter<String>(pickerdata: JsonDecoder().convert(agePickerData)),
    hideHeader: true,
    title: Container(
      margin: EdgeInsets.only(top: ScreenUtil.height/20),
      child: Text(
        '나이를 선택해주세요.',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600
        ),
        textAlign: TextAlign.center,
      ),
    ),
    height: 100.0,
    cancelText: '취소',
    confirmText: '확인',
    onConfirm: (Picker picker, List value)
      {
        int age = int.parse(picker.getSelectedValues()[1]);
        sl.get<ValidationBloc>().onAgeSelected(age);
        sl.get<SignUpBloc>().emitEvent(SignUpEventAgeSelect(age: age));
        FocusScope.of(context).requestFocus(FocusNode());
      },
    onCancel: () => FocusScope.of(context).requestFocus(FocusNode())
  ).showDialog(context);
}