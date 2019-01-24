import 'package:flutter/material.dart';
import 'package:privacy_of_animal/logics/form/login_bloc.dart';
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
    final LoginBloc bloc = LoginBloc();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Expanded(
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
                  top: height/6.2,
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
                ),
              ],
            ),
          ),
          Form(
            child: Column(
              children: <Widget>[
                StreamBuilder<String>(
                  stream: bloc.email,
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot){
                    return TextField(
                      decoration: InputDecoration(
                        labelText: '이메일',
                        errorText: snapshot.error
                      ),
                      onChanged: bloc.onEmailChanged,
                      keyboardType: TextInputType.emailAddress,
                    );
                  },
                ),
                StreamBuilder<String>(
                  stream: bloc.password,
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot){
                    return TextField(
                      decoration: InputDecoration(
                        labelText: '비밀번호',
                        errorText: snapshot.error
                      ),
                      onChanged: bloc.onPasswordChanged,
                      obscureText: true,
                      keyboardType: TextInputType.emailAddress,
                    );
                  },
                ),
                StreamBuilder<bool>(
                  stream: bloc.loginValid,
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