import 'package:flutter/material.dart';

class BlocNavigator {

  static void pop(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_){
      Navigator.of(context).pop();
    });
  }

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

  static void pushNamedAndRemoveAll(BuildContext context, String pageName){
    WidgetsBinding.instance.addPostFrameCallback((_){
      Navigator.of(context).pushNamedAndRemoveUntil(pageName, (_)=>false);
    });
  }

  static void pushReplacementNamed(BuildContext context, String pageName) {
    WidgetsBinding.instance.addPostFrameCallback((_){
      Navigator.of(context).pushReplacementNamed(pageName);
    });
  }
}