import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:privacy_of_animal/resources/constants.dart';

class MatchPage extends StatelessWidget {

  final String flare;
  final String message;
  final String animation;
  final Color buttonColor;
  final String buttonText;
  final VoidCallback callback;

  const MatchPage({Key key, 
    @required this.flare, 
    @required this.message,
    @required this.animation,
    @required this.buttonColor,
    @required this.buttonText,
    @required this.callback
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      height: ScreenUtil.height*0.9,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 50.0),
          Text(
            message,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40.0),
          Container(
            width: double.infinity,
            height: 300.0,
            child: FlareActor(
              flare,
              alignment: Alignment.center,
              fit: BoxFit.fitWidth,
              animation: animation,
            ),
          ),
          SizedBox(height: 10.0),
          GestureDetector(
            child: Container(
              width: ScreenUtil.width * 0.75,
              height: ScreenUtil.height * 0.08,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0), color: buttonColor),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  buttonText,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
              ),
            ),
            onTap: callback,
          )
        ],
      ),
    );
  }
}