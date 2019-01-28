import 'package:flutter/material.dart';
import 'package:privacy_of_animal/utils/stream_snackbar.dart';

DateTime currentBackPressTime = DateTime.now();

Future<bool> onWillPop(BuildContext context) {
  DateTime now = DateTime.now();
  if(now.difference(currentBackPressTime) > Duration(seconds: 2)){
    currentBackPressTime = now;
    streamSnackbar(context, '한번 더 누르시면 종료됩니다.');
    return Future.value(false);
  }
  return Future.value(true);
}