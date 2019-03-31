import 'package:flutter/material.dart';

class SameMatchTagForm extends StatelessWidget {

  final Color tagBorderColor;
  final String tagContent;

  SameMatchTagForm({
    @required this.tagBorderColor,
    @required this.tagContent
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: tagBorderColor,
          width: 3.0
        ),
        color: Colors.white.withOpacity(0.2)
      ),
      child: Text(
        '# $tagContent',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}