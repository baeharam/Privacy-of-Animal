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
            title: Text(''),
            icon: Image.asset('assets/images/components/match.png')
          ),
          BottomNavigationBarItem(
            title: Text(''),
            icon: Image.asset('assets/images/components/chat.png')
          ),
          BottomNavigationBarItem(
            title: Text(''),
            icon: Image.asset('assets/images/components/friend.png')
          ),
          BottomNavigationBarItem(
            title: Text(''),
            icon: Image.asset('assets/images/components/profile.png')
          )
        ],
      ),
    );
  }
}