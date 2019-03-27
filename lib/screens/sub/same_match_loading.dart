import 'package:flutter/material.dart';

class SameMatchLoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(height: 20.0),
          Text(
            '관심사가 비슷한 상대를 찾고 있습니다...',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15.0
            ),
          )
        ],
      ),
    );
  }
}