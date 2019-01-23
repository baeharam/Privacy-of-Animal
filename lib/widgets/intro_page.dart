import 'package:flutter/material.dart';
import 'package:privacy_of_animal/model/intro_page_model.dart';

class IntroPage extends StatelessWidget {

  final IntroPageModel introPageModel;

  IntroPage({this.introPageModel});


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height*0.66,
      color: introPageModel.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                introPageModel.aboveMessage,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'NanumGothic'
                ),
              ),
              Text(
                introPageModel.belowMessage,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'NanumGothic',
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10.0),
              CircleAvatar(
                backgroundImage: AssetImage(introPageModel.image),
              )
            ],
          )
        ],
      ),
    );
  }
}