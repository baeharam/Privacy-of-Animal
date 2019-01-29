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
    List<MemoryImage> images = List.generate(tags.length, (_) => MemoryImage(kTransparentImage));
    _tagBloc.emitEvent(TagEventImageLoad());

    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 40.0,bottom: 20.0,left: 50.0,right: 50.0),
            child: Text(
              '관심있는 태그 5개만 선택해주세요!',
              style: TextStyle(
                color: signUpBackgroundColor,
                fontWeight: FontWeight.bold,
                fontSize: 18.0
              ),
            ),
          ),
          BlocBuilder(
            bloc: _tagBloc,
            builder: (context, TagState state){
              if(state.isImageLoaded){
                images[state.tagIndex] = MemoryImage(Uint8List.fromList(state.compressedImage));
              }
              return GridView.builder(
                shrinkWrap: true,
                itemCount: tags.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0
                ),
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(10.0),
                itemBuilder: (BuildContext context, int index){
                  return Container(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: images[index],
                        fit: BoxFit.cover
                      )
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        tags[index].title,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  );
                }
              );
            },
          )
        ]
      )
    );
  }
}