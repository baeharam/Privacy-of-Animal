import 'package:flutter/material.dart';

void streamNavigator(BuildContext context, String pageName) {
  WidgetsBinding.instance.addPostFrameCallback((_){
    Navigator.of(context).pushNamed(pageName);
  });
}