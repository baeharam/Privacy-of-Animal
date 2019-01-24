import 'package:flutter/material.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/widgets/dashed_circle.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {

    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                ClipPath(
                  child: Container(
                    color: Colors.green,
                  ),
                  clipper: LoginBackgroundClipper(),
                ),
                Positioned(
                  left: width/2-62,
                  top: height/6.2,
                  child: Container(
                    width: 57*2+10.0,
                    height: 57*2+10.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle
                    )
                  ),
                ),
                Positioned(
                  left: width/2-57,
                  top: height/6,
                  child: DashedCircle(
                    child: CircleAvatar(
                      child: Text('로그인'),
                      radius: 57.0,
                      backgroundColor: Colors.white,
                    ),
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class LoginBackgroundClipper extends CustomClipper<Path>  {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(.0, size.height/5);
    final firstControlPoint = Offset(size.width/2, size.height*2/7);
    final firstEndPoint = Offset(size.width, size.height/5);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);
    path.lineTo(size.width,0.0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper){
    return true;
  }
  
}