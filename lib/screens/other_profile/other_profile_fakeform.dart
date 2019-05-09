import 'package:flutter/material.dart';

class OtherFakeProfileForm extends StatelessWidget {

  final String title;
  final String detail;

  OtherFakeProfileForm({
    @required this.title,
    @required this.detail
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '$title  ',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20.0
        ),
        children: [TextSpan(
          text: detail,
          style: TextStyle(color: Colors.white)
        )]
      )
    );
  }
}