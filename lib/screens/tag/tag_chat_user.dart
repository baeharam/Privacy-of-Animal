import 'package:flutter/material.dart';
import 'package:privacy_of_animal/resources/resources.dart';

class TagChatUser extends StatelessWidget {

  final String message;

  TagChatUser({@required this.message});

  @override
  Widget build(BuildContext context) {

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Spacer(),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: primaryBeige.withOpacity(0.5),
            borderRadius: BorderRadius.circular(3.0)
          ),
          child: Text(
            message
          ),
        )
      ],
    );
  }
}