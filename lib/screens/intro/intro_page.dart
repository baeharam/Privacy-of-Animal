import 'package:flutter/material.dart';
import 'package:privacy_of_animal/models/intro_page_model.dart';
import 'package:privacy_of_animal/resources/constants.dart';

class IntroPage extends StatelessWidget {

  final IntroPageModel introPageModel;

  IntroPage({this.introPageModel});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      height: ScreenUtil.height*0.7,
      color: introPageModel.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                introPageModel.aboveMessage,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0
                ),
              ),
              SizedBox(height: 5.0),
              Text(
                introPageModel.belowMessage,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0
                ),
              ),
              SizedBox(height: ScreenUtil.height/20),
              Container(
                width: CurrentPlatform.platform == TargetPlatform.android ? ScreenUtil.height/2.4: ScreenUtil.height/3,
                height: CurrentPlatform.platform == TargetPlatform.android ? ScreenUtil.height/2.4 : ScreenUtil.height/3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(introPageModel.image),
                    fit: BoxFit.cover
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(180.0)),
                  border: Border.all(color: Colors.white,width: 4.0)
                )
              )
            ],
          )
        ],
      ),
    );
  }
}