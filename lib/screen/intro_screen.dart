import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_helpers.dart';
import 'package:privacy_of_animal/intro/intro_pages.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/widgets/dots_indicator.dart';
import 'package:privacy_of_animal/widgets/intro_page.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {

  final PageController _pageController = PageController(initialPage: 1);

  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;

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
                PageView.builder(
                  controller: _pageController,
                  itemCount: pages.length,
                  itemBuilder: (BuildContext context, int index)
                    => IntroPage(introPageModel: pages[index]),
                ),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: DotsIndicator(
                        pageController: _pageController,
                        itemCount: pages.length,
                        onPageSelected: (int page){
                          _pageController.animateToPage(
                            page,
                            duration: _kDuration,
                            curve: _kCurve
                          );
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: height*0.3,
            width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.only(top: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _buildButton(width, height, '로그인', introLoginButtonColor),
                SizedBox(height: 25.0),
                _buildButton(width, height, '회원가입', introSignUpButtonColor)
              ],
            ),
          )
        ],
      )
    );
  }

  Widget _buildButton(double width, double height, String text, Color color){
    return Container(
      width: width*0.77,
      height: height*0.07,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
        boxShadow: [BoxShadow(
          color: Colors.grey,
          blurRadius: 3.0,
          spreadRadius: 0.02,
          offset: Offset(0.0,5.0)
        )]
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: introButtonTextColor,
            fontWeight: FontWeight.bold,
            fontSize: 15.0
          ),
        ),
      ),
    );
  }
}