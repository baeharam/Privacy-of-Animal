import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:privacy_of_animal/resources/constants.dart';
import 'package:privacy_of_animal/widgets/login_background.dart';
import 'package:privacy_of_animal/widgets/login_form.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
    void initState() {
      super.initState();
      SystemChrome.setEnabledSystemUIOverlays([]);
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              LoginBackground(),
              SizedBox(height: ScreenUtil.height/10),    
              LoginForm()     
            ]
          ),
        ),
      ),
    );
  }
}