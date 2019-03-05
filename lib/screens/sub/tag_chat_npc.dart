import 'package:flutter/material.dart';
import 'package:privacy_of_animal/resources/resources.dart';

class TagChatNPC extends StatelessWidget {

  final String message;
  final bool isBegin;

  TagChatNPC({
    @required this.message,
    @required this.isBegin
  });

  @override
  Widget build(BuildContext context) {
    Widget profileImage = Image(
      image: AssetImage('assets/images/components/tag_chat_npc.png'),
      width: ScreenUtil.width/6,
      height: isBegin ? ScreenUtil.width/6 : ScreenUtil.width/9,
      color:  isBegin ? null : Colors.transparent
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        profileImage,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            isBegin ? Text(
              isBegin ? '동물의 사생활' : '',
              style: TextStyle(
                color: primaryBlue,
                fontWeight: FontWeight.bold,
                fontSize: 10.0,
              ),
            ) : Container(),
            SizedBox(height: isBegin? 10.0 : 0.0),
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(3.0)
              ),
              child: Text(
                message
              ),
            )
          ],
        )
      ],
    );
  }
}