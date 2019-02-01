import 'package:flutter/material.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/resources/constants.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Color color;
  final Function callback;

  PrimaryButton({
    this.text,
    this.color,
    this.callback
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(30.0),
      elevation: 5.0,
      child: MaterialButton(
        minWidth: ScreenUtil.width*0.77,
        height: ScreenUtil.height*0.07,
        color: color,
        splashColor: Colors.transparent,
        onPressed: callback,
        child: Text(
          text,
          style: TextStyle(
            color: introButtonTextColor,
            fontWeight: FontWeight.bold,
            fontSize: 15.0
          ),
        ),
      ),
    );
  }
}