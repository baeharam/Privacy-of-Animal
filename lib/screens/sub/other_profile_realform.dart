import 'package:flutter/material.dart';

class OtherProfileRealForm extends StatelessWidget {

  final String title;
  final String detail;

  OtherProfileRealForm({
    @required this.title,
    @required this.detail
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
      child: Row(
        children: <Widget>[
          Text(
            '*'+title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15.0
            ),
          ),
          Spacer(),
          Text(
            detail,
            style: TextStyle(
              fontSize: 15.0
            ),
          )
        ],
      ),
    );
  }
}