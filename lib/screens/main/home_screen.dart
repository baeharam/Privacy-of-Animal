import 'package:flutter/material.dart';
import 'package:privacy_of_animal/resources/constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        items: [
          BottomNavigationBarItem(
            title: Text(''),
            icon: ImageIcon(
              AssetImage('assets/images/components/match.png'),
              size: ScreenUtil.width/4,
            )
          ),
          BottomNavigationBarItem(
            title: Text(''),
            icon: ImageIcon(
              AssetImage('assets/images/components/chat.png'),
              size: ScreenUtil.width/4,
            )
          ),
          BottomNavigationBarItem(
            title: Text(''),
            icon: ImageIcon(
              AssetImage('assets/images/components/friend.png'),
              size: ScreenUtil.width/4,
            )
          ),
          BottomNavigationBarItem(
            title: Text(''),
            icon: ImageIcon(
              AssetImage('assets/images/components/profile.png'),
              size: ScreenUtil.width/4,
            )
          )
        ],
        fixedColor: Colors.red,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}