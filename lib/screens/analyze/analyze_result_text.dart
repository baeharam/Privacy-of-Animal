import 'package:flutter/material.dart';
import 'package:privacy_of_animal/resources/resources.dart';

class ResultText extends StatelessWidget {

  final String title;
  final String value;
  final String confidence;

  ResultText({
    @required this.title,
    @required this.value,
    @required this.confidence
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: ScreenUtil.width/8,right: ScreenUtil.width/8),
      child: Row(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold
            )
          ),
          SizedBox(width: ScreenUtil.width/10),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold
              )
            ),
          ),
          Text(
            '$confidence%',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold
            )
          )
        ],
      ),
    );
  }
}