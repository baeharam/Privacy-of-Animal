import 'package:flutter/material.dart';
import 'package:privacy_of_animal/logics/global/initialize_api.dart';
import 'package:privacy_of_animal/resources/resources.dart';
import 'package:privacy_of_animal/screens/intro/intro_page.dart';
import 'package:privacy_of_animal/utils/back_button_dialog.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/widgets/dots_indicator.dart';
import 'package:privacy_of_animal/widgets/primary_button.dart';

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

  @override
  Widget build(BuildContext context) {
    sl.get<InitializeAPI>().constantInitialize(context);

    return FadeTransition(
      opacity: _transitionAnimation, 
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: WillPopScope(
          onWillPop: () => BackButtonAction.oneMorePressToExit(context,_scaffoldKey.currentState),
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
                    PrimaryButton(
                      text: '로그인', 
                      color: primaryBeige,
                      callback: () => Navigator.of(context).pushNamed(routeLoginDecision)
                    ),
                    SizedBox(height: 25.0),
                    PrimaryButton(
                      text: '회원가입', 
                      color: primaryGrey,
                      callback: () => Navigator.of(context).pushNamed(routeSignUpDecision)
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