import 'package:flutter/material.dart';
import 'package:privacy_of_animal/resources/resources.dart';

class TagChatUser extends StatefulWidget {

  final String message;

  TagChatUser({
    @required this.message
  });

  @override
  TagChatUserState createState() {
    return new TagChatUserState();
  }
}

class TagChatUserState extends State<TagChatUser> {

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
            widget.message
          ),
        )
      ],
    );
  }
}