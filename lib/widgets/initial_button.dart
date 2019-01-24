import 'package:flutter/material.dart';
import 'package:privacy_of_animal/resources/colors.dart';

class InitialButton extends StatefulWidget {
  final String text;
  final Color color;
  final Function callback;

  InitialButton({
    this.text,
    this.color,
    this.callback
  });

  @override
  InitialButtonState createState() {
    return new InitialButtonState();
  }
}

class InitialButtonState extends State<InitialButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(30.0),
      elevation: 5.0,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width*0.77,
        height: MediaQuery.of(context).size.height*0.07,
        color: widget.color,
        splashColor: Colors.transparent,
        onPressed: widget.callback,
        child: Text(
          widget.text,
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