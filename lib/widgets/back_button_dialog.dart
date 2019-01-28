import 'package:flutter/material.dart';

class BackButtonAction {
  static DateTime currentBackPressTime;

  static Future<bool> onWillPop(BuildContext context, ScaffoldState state) {
    DateTime now = DateTime.now();
    if(now.difference(currentBackPressTime) > Duration(seconds: 1)){
      currentBackPressTime = now;
      state.showSnackBar(SnackBar(content: Text('한번 더 누르시면 종료됩니다.'),duration: const Duration(milliseconds: 300)));
      return Future.value(false);
    }
    return Future.value(true);
  }
}