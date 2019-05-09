import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:privacy_of_animal/resources/resources.dart';

class MatchButton extends StatelessWidget {
  const MatchButton(
      {Key key,
      this.animation,
      this.icon,
      this.title,
      this.baseColor,
      this.roundColor})
      : super(key: key);

  final String title;
  final String icon;
  final String animation;
  final Color baseColor;
  final Color roundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil.width * 0.9,
      height: ScreenUtil.height * 0.2,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: ScreenUtil.width * 0.1,
            top: ScreenUtil.height * 0.03,
            child: Container(
              width: ScreenUtil.width * 0.75,
              height: ScreenUtil.height * 0.14,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0), color: baseColor),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
              ),
            ),
          ),
          Positioned(
            top: ScreenUtil.height * 0.1 - ScreenUtil.width * 0.11,
            child: Container(
              height: ScreenUtil.width * 0.22,
              width: ScreenUtil.width * 0.22,
              decoration: BoxDecoration(
                  color: roundColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4.0)),
              child: FlareActor(
                icon,
                alignment: Alignment.center,
                fit: BoxFit.fitWidth,
                animation: animation,
              ),
            ),
          ),
        ],
      ),
    );
  }
}