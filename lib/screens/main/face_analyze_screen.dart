import 'package:flutter/material.dart';
import 'package:privacy_of_animal/resources/resources.dart';
import 'package:privacy_of_animal/widgets/arc_background_faceAnalyze.dart';
import 'package:privacy_of_animal/widgets/profile_percent.dart';
import 'dart:math';
class FaceAnalyze extends StatefulWidget{
  @override
  _FaceAnalyzeState createState() => _FaceAnalyzeState(); 
}

class _FaceAnalyzeState extends State<FaceAnalyze>{

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double image_position_left = (width - (CurrentPlatform.platform == TargetPlatform.android ? height/2.4: height*0.24 ))/2;
    double image_position_top = height/7;
    double image_radius = CurrentPlatform.platform == TargetPlatform.android ? height/2.4:  height*0.24;
    double arc_position_left = width/2;
    double arc_position_top = height/7 + height*0.12 ;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryBlue,
        title: Text("분석결과"),
      ),
      body: Center(
        child: Stack(
                children: <Widget>[

                  //아래 배경
                  ArcBackground(
                      backgroundColor: primaryGreen,
                    ),

                  // draw arc
                  Positioned(
                    // left: (width - (CurrentPlatform.platform == TargetPlatform.android ? height/2.4: height*0.26 ))/2,
                    // top: height/7 - (CurrentPlatform.platform == TargetPlatform.android ? height/2.4: height*0.02 )/2,
                    left: arc_position_left, //ios
                    top: arc_position_top, // ios
                    child: CustomPaint(
                      painter: ArcPainter(width,height,25.0,Colors.green[100],primaryGreen) // screen width, screen height, percent, backgroundColor, arc Color
                    ),
                  ),

                  
                  // Image 사자
                  Positioned(
                    // left: (width - (CurrentPlatform.platform == TargetPlatform.android ? height/2.4: height*0.24 ))/2,
                    left: image_position_left,
                    top: image_position_top,
                    child: Container(
                      width: CurrentPlatform.platform == TargetPlatform.android ? height/2.4: image_radius,
                      height: CurrentPlatform.platform == TargetPlatform.android ? height/2.4 : image_radius,       
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/animals/lion.jpg"),
                          fit: BoxFit.cover
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(180.0)),
                      ),
                    ),
                  ),

                ],
              )
        ),
      );
  }
}
