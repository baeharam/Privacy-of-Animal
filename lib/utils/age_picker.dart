import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:privacy_of_animal/resources/constants.dart';

int showAgePicker(BuildContext context) {
  Picker(
    adapter: PickerDataAdapter<String>(pickerdata: JsonDecoder().convert(AgePickerData)),
    hideHeader: true,
    title: Text('나이를 선택해주세요.'),
    onConfirm: (Picker picker, List value){
      return(int.parse(picker.getSelectedValues()[1]));
    }
  ).showDialog(context);
  return 0;
}