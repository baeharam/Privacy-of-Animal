import 'package:flutter/material.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/resources/constants.dart';
import 'package:privacy_of_animal/widgets/dashed_circle.dart';

class ArcBackground extends StatefulWidget {

  final Color backgroundColor;
  final Color dashColor;
  final String title;

  ArcBackground({
    @required this.backgroundColor,
    @required this.dashColor,
    @required this.title
  });

  @override
  _ArcBackgroundState createState() => _ArcBackgroundState();
}

class _ArcBackgroundState extends State<ArcBackground> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: ScreenUtil.height/3,
      child: Stack(
        children: <Widget>[
          ClipPath(
            child: Container(
              color: widget.backgroundColor,
            ),
            clipper: BackgroundClipper(),
          ),
          Positioned(
            left: ScreenUtil.width/2-dashedBackgroundCircleDiameter/2,
            // top: ScreenUtil.height/7,
            top: ScreenUtil.height/4.4-dashedBackgroundCircleDiameter/2, // look beter in ios
            child: Container(
              width: dashedBackgroundCircleDiameter,
              height: dashedBackgroundCircleDiameter,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle
              )
            ),
          ),
          Positioned(
            left: ScreenUtil.width/2-dashedCircleRadius,
            top: ScreenUtil.height/6,
            child: DashedCircle(
              child: CircleAvatar(
                child: Text(
                  widget.title,
                  style: TextStyle(
                    color: loginTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                  )
                ),
                radius: dashedCircleRadius,
                backgroundColor: Colors.white,
              ),
              gapSize: 7,
              dashes: 40,
              color: widget.dashColor,
            ),
          )
        ],
      ),
    );
  }
}

class BackgroundClipper extends CustomClipper<Path>  {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(.0, size.height/1.7);
    final firstControlPoint = Offset(size.width/2, size.height*2/2.3);
    final firstEndPoint = Offset(size.width, size.height/1.7);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);
    path.lineTo(size.width,0.0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper){
    return true;
  }
  
}