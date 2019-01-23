import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<bool> onWillPop(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context){
      return AlertDialog(
        content: Text('정말로 종료하시겠습니까?'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
            child: Text('예'),
          ),
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('아니오'),
          )
        ],
      );
    }
  ) ?? false;
}