import 'package:flutter/material.dart';

class SameMatchFakeProfileForm extends StatelessWidget {

  final String content;

  SameMatchFakeProfileForm({@required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 5.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 3.0
        ),
        color: Colors.white.withOpacity(0.2)
      ),
      child: Text(
        content,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}