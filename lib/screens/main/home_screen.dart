import 'package:flutter/material.dart';

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
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/components/match.png')
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/components/chat.png')
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/components/friend.png')
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/components/profile.png')
          )
        ],
      ),
    );
  }
}