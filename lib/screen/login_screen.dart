import 'package:flutter/material.dart';
import 'package:privacy_of_animal/logics/validation/validation_bloc.dart';
import 'package:privacy_of_animal/resources/constants.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/widgets/dashed_circle.dart';
import 'package:privacy_of_animal/widgets/initial_button.dart';

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
      body: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: ListView(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: height/3,
              child: Stack(
                children: <Widget>[
                  ClipPath(
                    child: Container(
                      color: loginBackgroundColor,
                    ),
                    clipper: LoginBackgroundClipper(),
                  ),
                  Positioned(
                    left: width/2-dashedBackgroundCircleDiameter/2,
                    top: height/6.6,
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
                    left: width/2-dashedCircleRadius,
                    top: height/6,
                    child: DashedCircle(
                      child: CircleAvatar(
                        child: Text(
                          '로그인',
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
                      color: loginBackgroundColor,
                    ),
                  )
                ],
              ),
            ),
            _buildLoginFormColumn(width, height)
          ],
        ),
      ),
    );
  }

  Widget _buildLoginFormColumn(double width, double height) {

    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    final validationBloc = ValidationBloc();

    return Container(
      height: height/2,
      width: width/1.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          StreamBuilder<String>(
            stream: validationBloc.email,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot){
              return Container(
                width: width/1.4,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: '이메일',
                    errorText: snapshot.error,
                  ),
                  onChanged: validationBloc.onEmailChanged,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                ),
              );
            },
          ),
          SizedBox(height: 20.0),
          StreamBuilder<String>(
            stream: validationBloc.password,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot){
              return Container(
                width: width/1.4,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: '비밀번호',
                    errorText: snapshot.error
                  ),
                  onChanged: validationBloc.onPasswordChanged,
                  obscureText: true,
                  keyboardType: TextInputType.emailAddress,
                  controller: _passwordController,
                ),
              );
            },
          ),
          SizedBox(height: 50.0),
          StreamBuilder<bool>(
            stream: validationBloc.loginValid,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
              return InitialButton(
                text: '로그인',
                color: introLoginButtonColor,
                callback: (snapshot.hasData && snapshot.data==true) ? (){} : null,
              );
            },
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