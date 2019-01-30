import 'package:flutter/material.dart';
import 'package:privacy_of_animal/resources/resources.dart';
import 'package:privacy_of_animal/screens/sub/intro_page.dart';
import 'package:privacy_of_animal/widgets/back_button_dialog.dart';
import 'package:privacy_of_animal/widgets/dots_indicator.dart';
import 'package:privacy_of_animal/widgets/initial_button.dart';

// import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
import 'package:privacy_of_animal/widgets/flutter_statusbar_manager.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> with SingleTickerProviderStateMixin{

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PageController _pageController;
  AnimationController _animationController;
  Animation _transitionAnimation;
 
  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;

  @override
    void initState() {
      super.initState();
      FlutterStatusbarManager.setHidden(false);
      _pageController = PageController(initialPage: 0);
      _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300)
      );
      _transitionAnimation = Tween(begin: 0.7,end: 1.0).animate(_animationController);
      _animationController.forward();
      BackButtonAction.currentBackPressTime = DateTime.now();
    }

  @override
    void dispose() {
      _pageController.dispose();
      _animationController.dispose();
      super.dispose();
    }

  void initializeConstants(BuildContext context){
    ScreenUtil.width = MediaQuery.of(context).size.width;
    ScreenUtil.height = MediaQuery.of(context).size.height;
    CurrentPlatform.platform = Theme.of(context).platform;
  }

  @override
  Widget build(BuildContext context) {

    initializeConstants(context);

    return FadeTransition(
      opacity: _transitionAnimation, 
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: WillPopScope(
          onWillPop: () => BackButtonAction.onWillPop(context,_scaffoldKey.currentState),
          child: Column(
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
                height: ScreenUtil.height*0.3,
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
                      callback: () => Navigator.of(context).pushNamed('/loginDecision')
                    ),
                    SizedBox(height: 25.0),
                    InitialButton(
                      text: '회원가입', 
                      color: introSignUpButtonColor,
                      callback: () => Navigator.of(context).pushNamed('/signUpDecision')
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}