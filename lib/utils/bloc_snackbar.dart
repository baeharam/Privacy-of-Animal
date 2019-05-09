import 'package:flutter/material.dart';

class BlocSnackbar {
  static void show(BuildContext context, String message) {
    WidgetsBinding.instance.addPostFrameCallback((_){
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 700),
      ));
    });
  } 
}