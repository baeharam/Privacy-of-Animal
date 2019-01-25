import 'package:flutter/material.dart';

class StreamNavigator {
  static void pushNamed(BuildContext context, String pageName) {
    WidgetsBinding.instance.addPostFrameCallback((_){
      Navigator.of(context).pushNamed(pageName);
    });
  }

  static void pushNamedAndRemoveUntil(BuildContext context, String pageName, String remainPageName) {
    WidgetsBinding.instance.addPostFrameCallback((_){
      Navigator.of(context).pushNamedAndRemoveUntil(pageName, ModalRoute.withName(remainPageName));
    });
  }
}



