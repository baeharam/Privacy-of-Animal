import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:privacy_of_animal/collections/intro_pages.dart';
import 'package:privacy_of_animal/decision/authentication_decision.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/widgets/back_button_dialog.dart';
import 'package:privacy_of_animal/widgets/dots_indicator.dart';
import 'package:privacy_of_animal/widgets/initial_button.dart';
import 'package:privacy_of_animal/widgets/intro_page.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> with SingleTickerProviderStateMixin{

  PageController _pageController;
  AnimationController _animationController;
  Animation _transitionAnimation;

  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;

  @override
    void initState() {
      super.initState();
      SystemChrome.setEnabledSystemUIOverlays([]);
      _pageController = PageController(initialPage: 0);
      _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300)
      );
      _transitionAnimation = Tween(begin: 0.7,end: 1.0).animate(_animationController);
      _animationController.forward();
    }

  @override
    void dispose() {
      _pageController.dispose();
      _animationController.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () => onWillPop(context),
      child: FadeTransition(
        opacity: _transitionAnimation, 
        child: Scaffold(
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
                    InitialButton(
                      text: '로그인', 
                      color: introLoginButtonColor,
                      callback: () => Navigator.of(context).pushNamed('/decision')
                    ),
                    SizedBox(height: 25.0),
                    InitialButton(
                      text: '회원가입', 
                      color: introSignUpButtonColor,
                      callback: () => Navigator.of(context).pushNamed('/signUp')
                    )
                  ],
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}