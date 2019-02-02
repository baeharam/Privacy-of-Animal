import 'package:flutter/material.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/resources/constants.dart';
import 'package:privacy_of_animal/widgets/dashed_circle.dart';

class ArcBackground extends StatefulWidget {

  final Color backgroundColor;

  ArcBackground({
    @required this.backgroundColor,
  });

  @override
  _ArcBackgroundState createState() => _ArcBackgroundState();
}

class _ArcBackgroundState extends State<ArcBackground> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.infinity,
      // height: ScreenUtil.height/3,
      height: MediaQuery.of(context).size.height,
      child:ClipPath(
            child: Container(
              color: widget.backgroundColor,
            ),
            clipper: BackgroundClipper(),
          ),
    );
  }
}

class BackgroundClipper extends CustomClipper<Path>  {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(.0, size.height*4/9);
    path.lineTo(.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height*4/9);
    final firstControlPoint = Offset(size.width*0.5,size.height*1/7);
    final firstEndPoint = Offset(.0,size.height*4/9);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);

    // final firstControlPoint = Offset(.0, size.height/2);
    // final firstEndPoint = Offset(size.width/2, size.height/2);
    // path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);
    // path.lineTo(.0,size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper){
    return true;
  }
  
}