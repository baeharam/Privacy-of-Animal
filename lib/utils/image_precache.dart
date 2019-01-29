import 'dart:isolate';

import 'package:flutter/widgets.dart';
import 'package:privacy_of_animal/resources/constants.dart';

Isolate isolate;

void imagePrecache(BuildContext context) async{
  ReceivePort receivePort = ReceivePort();
  isolate = await Isolate.spawn(entryPoint, message)
  for(int i=0; i<tags.length; i++){
    precacheImage(AssetImage(tags[i].image), context);
  }
}