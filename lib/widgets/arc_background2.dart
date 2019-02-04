import 'package:flutter/material.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/resources/constants.dart';

 class ArcBackground2 extends StatefulWidget {
   @override
  _ArcBackground2State createState() => _ArcBackground2State();
}

 class _ArcBackground2State extends State<ArcBackground2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.height,
      child:ClipPath(
            child: Container(
              color: primaryGreen,
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
    path.close();
    return path;
  }

   @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
 } 