import 'package:flutter/material.dart';
import 'package:privacy_of_animal/resources/resources.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_helpers.dart';
import 'package:privacy_of_animal/logics/face_analyze/face_analyze.dart';
import 'package:privacy_of_animal/screens/sub/face_analyze.dart';
import 'package:privacy_of_animal/widgets/arc_background_faceAnalyze.dart';
import 'dart:math';
class FaceAnalyze extends StatefulWidget{
  @override
  _FaceAnalyzeState createState() => _FaceAnalyzeState(); 
}

class _FaceAnalyzeState extends State<FaceAnalyze>{

  
  FaceAnalyzeBloc _faceAnalyzeBloc = sl.get<FaceAnalyzeBloc>();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryBlue,
        title: Text("분석결과"),
      ),
      body: Center(
        child: BlocBuilder(
          bloc: _faceAnalyzeBloc,
          builder: (context, FaceAnalyzeState state){
            if(!state.doneAnalyze){
              _faceAnalyzeBloc.emitEvent(FaceAnalyzeEventUnAnaylze());
             
              return  Stack(
                children: <Widget>[

                  //아래 배경
                  ArcBackground(
                      backgroundColor: primaryGreen,
                    ),
                  // 닮은꼴 이미지
                  Positioned(
                    left: (width - (CurrentPlatform.platform == TargetPlatform.android ? height/2.4: height*0.26 ))/2,
                    top: height/7 - (CurrentPlatform.platform == TargetPlatform.android ? height/2.4: height*0.02 )/2,
                    child: Container(
                      width: CurrentPlatform.platform == TargetPlatform.android ? height/2.4:  height*0.26,
                      height: CurrentPlatform.platform == TargetPlatform.android ? height/2.4 : height*0.26,       
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        border: Border.all(width: 1.0,color: primaryGreen),
                        borderRadius: BorderRadius.all(Radius.circular(180.0)),
                      ),
                    ),
                  ),
                  Positioned(
                    // left: (width - (CurrentPlatform.platform == TargetPlatform.android ? height/2.4: height*0.26 ))/2,
                    // top: height/7 - (CurrentPlatform.platform == TargetPlatform.android ? height/2.4: height*0.02 )/2,
                    left: width/2,
                    top: height/7 + height*0.12,
                    child: CustomPaint(
                      painter: new _ArcPainter(height,width,21)
                    ),
                  ),
                  Positioned(
                    left: (width - (CurrentPlatform.platform == TargetPlatform.android ? height/2.4: height*0.24 ))/2,
                    top: height/7,
                    child: Container(
                      width: CurrentPlatform.platform == TargetPlatform.android ? height/2.4:  height*0.24,
                      height: CurrentPlatform.platform == TargetPlatform.android ? height/2.4 : height*0.24,       
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
              );
            }
            else{
              _faceAnalyzeBloc.emitEvent(FaceAnalyzeEventAnaylzeDone());
              // return FaceAnalyzeSub();
              return Container();
            }
          },
        ),),
      );
  }
}

class _ArcPainter extends CustomPainter {
  double height;
  double width;
  double percent;
  _ArcPainter(
    @required this.height,
    @required this.width,
    @required this.percent
  );

  @override
  bool shouldRepaint(_ArcPainter oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Rect rect = Rect.fromLTWH(0.0, 0.0, size.width, size.height);
    Rect rect =Rect.fromCircle(center: new Offset(size.width/2,size.height/2), radius: height*0.12);
    double angle = -2*pi*(percent/100);
    double nono =  -2*pi*(percent/100);
    

      // canvas.drawLine(
      //   new Offset(size.width/2, -height*0.15),
      //   new Offset(size.width/2,-height*0.11),
      //   Paint()
      //     ..color = Colors.black
      //     ..strokeWidth = 2.0
      //     ..style = PaintingStyle.stroke
      //     );

      canvas.drawLine(
        new Offset(size.width/2 + (size.width/2+height*0.15)*sin(angle), -(size.width/2 + (size.width/2+height*0.15)*cos(angle))),
        new Offset(size.width/2 + (size.width/2+height*0.11)*sin(angle), -(size.width/2 + (size.width/2+height*0.11)*cos(angle))),
        Paint()
          ..color = Colors.black
          ..strokeWidth = 2.0
          ..style = PaintingStyle.stroke);

      canvas.drawArc(
        rect,
        -pi/2,
        nono,
        false,
        Paint()
          ..color = Colors.teal
          ..strokeWidth = 20.0
          ..style = PaintingStyle.stroke);
    
    TextSpan span = new TextSpan(style: new TextStyle(color: Colors.black, fontSize: 20.0), text: "$percent %");
    TextPainter tp = new TextPainter(text: span, textAlign: TextAlign.left, textDirection: TextDirection.ltr);
    tp.layout();
    Offset smallerThan30 = new Offset(size.width/2 + (size.width/2+height*0.22)*sin(angle), -(size.width/2 + (size.width/2+height*0.22)*cos(angle)));
    Offset smallerThan45 = new Offset(size.width/2 + (size.width/2+height*0.17)*sin(angle), -(size.width/2 + (size.width/2+height*0.17)*cos(angle)));
    Offset biggerThan45 = new Offset(size.width/2 + (size.width/2+height*0.15)*sin(angle), -(size.width/2 + (size.width/2+height*0.15)*cos(angle)));
    // tp.paint(canvas, percent > 35 ? biggerThan45 : smallerThan50);
    tp.paint(canvas,smallerThan30);
  }

}