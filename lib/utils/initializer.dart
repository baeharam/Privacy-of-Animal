import 'package:flutter/material.dart';
import 'package:privacy_of_animal/resources/resources.dart';

void initializeApp(BuildContext context) {
  ScreenUtil.width = MediaQuery.of(context).size.width;
  ScreenUtil.height = MediaQuery.of(context).size.height;
  CurrentPlatform.platform = Theme.of(context).platform;
}