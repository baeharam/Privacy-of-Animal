import 'package:flutter/material.dart';
import 'package:privacy_of_animal/resources/strings.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Image.asset(loginFormImage),
              Image.asset(loginBackgroundImage)
            ],
          )
        ],
      ),
    );
  }
}