import 'package:flutter/material.dart';
import 'package:privacy_of_animal/resources/resources.dart';

class TagChatNPC extends StatefulWidget {

  final String message;

  TagChatNPC({
    @required this.message
  });

  @override
  TagChatNPCState createState() {
    return new TagChatNPCState();
  }
}

class TagChatNPCState extends State<TagChatNPC> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Image(
          image: AssetImage('assets/images/components/tag_chat_npc.png'),
          width: ScreenUtil.width/6,
          height: ScreenUtil.width/6,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '동물의 사생활',
                style: TextStyle(
                  color: primaryBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0,
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(3.0)
                ),
                child: Text(
                  widget.message
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}