import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_helpers.dart';
import 'package:privacy_of_animal/resources/colors.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {

    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          BlocEventStateBuilder(
            bloc: BlocProvider.of<IntroBloc>(context),
            builder: (BuildContext context, AsyncSnapshot<IntroState> snapshot){

            },
          ),
        ],
      )
    );
  }

  Widget _buildIntroMainWidget(Color backgroundColor, double height, String messageAbove, String messageBelow, String image) {
    return Container(
      width: double.infinity,
      height: height*0.66,
      color: backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                messageAbove,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'NanumGothic'
                ),
              ),
              Text(
                messageBelow,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'NanumGothic',
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10.0),
              CircleAvatar(
                backgroundImage: AssetImage(image),
              )
            ],
          )
        ],
      ),
    );
  }
}