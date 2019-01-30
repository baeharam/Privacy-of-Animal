import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_helpers.dart';
import 'package:privacy_of_animal/logics/tag/tag.dart';
import 'package:privacy_of_animal/resources/resources.dart';
import 'package:transparent_image/transparent_image.dart';

class TagScreen extends StatefulWidget {
  @override
  _TagScreenState createState() => _TagScreenState();
}

class _TagScreenState extends State<TagScreen> {


  @override
  Widget build(BuildContext context) {

    final TagBloc _tagBloc = TagBloc();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children:<Widget>[
          Container(
            padding: const EdgeInsets.only(top: 40.0,left: 50.0,right: 50.0),
            child: Text(
              '관심있는 태그 5개만 선택해주세요!',
              style: TextStyle(
                color: signUpBackgroundColor,
                fontWeight: FontWeight.bold,
                fontSize: 18.0
              ),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            itemCount: tags.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.only(bottom: ScreenUtil.height/6),
            itemBuilder: (BuildContext context, int index){
              return  GestureDetector(
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Image(
                      image: tags[index].image,
                      width: ScreenUtil.width/3,
                      height: ScreenUtil.width/3
                    ),
                    BlocBuilder(
                      bloc: _tagBloc,
                      builder: (context, TagState state){
                        return Container(
                          width: ScreenUtil.width/3-10.0,
                          height: ScreenUtil.width/3-10.0,
                          decoration: BoxDecoration(
                            color: state.tagIndex==index ? Colors.black.withOpacity(0.5) : Colors.transparent,
                            shape: BoxShape.circle
                          ),
                        );
                      }
                    ),
                    Positioned(
                      bottom: 20.0,
                      child: Text(
                        tags[index].title,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ],
                ),
                onTap: () => _tagBloc.emitEvent(TagEventSelect(index: index)),
              );
            }
          )
        ]
      )
    )
    );
  }
}