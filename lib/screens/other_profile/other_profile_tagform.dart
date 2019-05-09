import 'package:flutter/material.dart';
import 'package:privacy_of_animal/resources/colors.dart';

class OtherProfileTagForm extends StatelessWidget {
  final String content;
  final bool isTitle;
  OtherProfileTagForm({@required this.content, @required this.isTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: isTitle ? primaryBlue : primaryGreen,
          width: 3.0
        )
      ),
      child: Text(
        '# $content'
      ),
    );
  }
}