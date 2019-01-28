import 'package:flutter/material.dart';
import 'package:privacy_of_animal/resources/constants.dart';


class TagSelectScreen extends StatefulWidget {
  @override
  _TagSelectScreenState createState() => _TagSelectScreenState();
}

class _TagSelectScreenState extends State<TagSelectScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Text(
            '관심있는 태그 3개 이상 선택해주세요!'
          ),
        ),
        GridView.builder(
          itemCount: tags.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (BuildContext context, int index){
            return Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: tags[index].image
                )
              ),
              child: Text(tags[index].title),
            );
          },
        )
      ],
    );
  }
}