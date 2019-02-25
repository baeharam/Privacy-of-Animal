import 'package:flutter/material.dart';
import 'package:privacy_of_animal/resources/colors.dart';

void profileHeroAnimation({@required BuildContext context, @required String image}) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context){
        return Scaffold(
          body: Container(
            alignment: Alignment.center,
            color: primaryBlue,
            child: Hero(
              child: GestureDetector(
                child: Image(
                  image: AssetImage(image),
                ),
                onTap: Navigator.of(context).pop,
              ),
              tag: image,
            ),
          ),
        );
      }
    ));
  }