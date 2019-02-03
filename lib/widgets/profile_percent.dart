import 'package:flutter/material.dart';
import 'package:privacy_of_animal/widgets/arc_background_faceAnalyze.dart';
import 'dart:math';
import 'package:privacy_of_animal/resources/resources.dart';



class ArcPainter extends CustomPainter {
  double height;
  double width;
  double percent;
  Color backgroundColor;
  Color arcColor;
  ArcPainter(
    @required this.width,
    @required this.height,
    @required this.percent,
    @required this.backgroundColor,
    @required this.arcColor
  );

  @override
  bool shouldRepaint(ArcPainter oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Rect rect = Rect.fromLTWH(0.0, 0.0, size.width, size.height);
    Rect rect =Rect.fromCircle(center: new Offset(size.width/2,size.height/2), radius: height*0.12);
    double angle = -2*pi*(percent/100);
  
      //배경
      canvas.drawCircle(
        new Offset(size.width/2,size.height/2),
        height*0.13,
        Paint()
          ..color = backgroundColor//배경색
          ..style = PaintingStyle.fill
        );

      // arc
      canvas.drawArc(
        rect,
        -pi/2,
        angle,
        false,
        Paint()
          ..color = arcColor
          ..strokeWidth = 20.0
          ..style = PaintingStyle.stroke);
      // draw line
      canvas.drawLine(
        new Offset(size.width/2 + (size.width/2+height*0.14)*sin(angle), -(size.width/2 + (size.width/2+height*0.14)*cos(angle))),
        new Offset(size.width/2 + (size.width/2+height*0.11)*sin(angle), -(size.width/2 + (size.width/2+height*0.11)*cos(angle))),
        Paint()
          ..color = Colors.black
          ..strokeWidth = 2.0
          ..style = PaintingStyle.stroke);
    
    // text: percent
    TextSpan span = new TextSpan(style: new TextStyle(color: Colors.black, fontSize: height*0.02), text: "$percent %");
    TextPainter tp = new TextPainter(text: span, textAlign: TextAlign.left, textDirection: TextDirection.ltr);
    tp.layout();

    //percent text // offset이 percent에 따라서 위치가 달라서 구별함
    Offset smallerThan30 = new Offset(size.width/2 + (size.width/2+height*0.20)*sin(angle), -(size.width/2 + (size.width/2+height*0.20)*cos(angle)));
    Offset smallerThan35 = new Offset(size.width/2 + (size.width/2+height*0.18)*sin(angle), -(size.width/2 + (size.width/2+height*0.18)*cos(angle)));
    Offset biggerThan40 = new Offset(size.width/2 + (size.width/2+height*0.15)*sin(angle), -(size.width/2 + (size.width/2+height*0.15)*cos(angle)));
    // tp.paint(canvas, percent > 35 ? biggerThan45 : smallerThan50);
    if (percent < 33)
      tp.paint(canvas,smallerThan30);
    if (33 <= percent && percent <=39)
      tp.paint(canvas, smallerThan35);
    else if(39 < percent)
      tp.paint(canvas,biggerThan40);
  }

}