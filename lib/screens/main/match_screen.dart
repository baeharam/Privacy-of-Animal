import 'package:flutter/material.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/resources/constants.dart';
import 'package:privacy_of_animal/widgets/arc_background3.dart';

class MatchScreen extends StatefulWidget {
  @override
  _MatchScreenState createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '????',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: primaryBlue,
        actions: [
          IconButton(
            icon: Icon(Icons.filter),
            onPressed: (){},
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: -ScreenUtil.height/10,
            left: -ScreenUtil.width/2.5,
            width: ScreenUtil.width*1.1,
            height: ScreenUtil.width*1.1,
            child: Image(
              image: AssetImage('assets/images/components/match_tag_circle.png'),
            ),
          ),
          Positioned(
            bottom: -ScreenUtil.height/10,
            right: -ScreenUtil.width/2.5,
            width: ScreenUtil.width*1.1,
            height: ScreenUtil.width*1.1,
            child: Image(
              image: AssetImage('assets/images/components/match_random_circle.png'),
            ),
          )
        ],
      )
    );
  }
}