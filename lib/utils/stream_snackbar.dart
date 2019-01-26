import 'package:flutter/material.dart';

void streamSnackbar(BuildContext context, String message) {
  WidgetsBinding.instance.addPostFrameCallback((_){
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(milliseconds: 700),
    ));
  });
}