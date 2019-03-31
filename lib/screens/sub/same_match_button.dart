import 'package:flutter/material.dart';

class SameMatchButton extends StatelessWidget {

  final Color color;
  final String title;
  final VoidCallback onPressed;

  SameMatchButton({
    @required this.color,
    @required this.title,
    @required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 15.0
        ),
      ),
      elevation: 5.0,
      onPressed: onPressed
    );
  }
}