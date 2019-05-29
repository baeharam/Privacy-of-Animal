import 'package:flutter/material.dart';
import 'package:privacy_of_animal/logics/global/initialize_api.dart';
import 'package:privacy_of_animal/logics/same_match/same_match.dart';
import 'package:privacy_of_animal/resources/resources.dart';
import 'package:privacy_of_animal/screens/home_match/match_page.dart';
import 'package:privacy_of_animal/utils/back_button_dialog.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/widgets/dots_indicator.dart';

class MatchPageView extends StatefulWidget {
  @override
  _MatchPageViewState createState() => _MatchPageViewState();
}

class _MatchPageViewState extends State<MatchPageView> with SingleTickerProviderStateMixin{

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
                      itemCount: 2,
                      itemBuilder: (BuildContext context, int index){
                        if(index==0) {
                          return MatchPage(
                            flare: "assets/images/components/magnet.flr",
                            message: '당신의 관심사\n저희가 상대방을 찾아드립니다.',
                            animation: 'Move',
                            buttonColor: primaryGreen,
                            buttonText: '추천받기',
                            callback: () {
                              sl.get<SameMatchBloc>().emitEvent(SameMatchEventFindUser());
                              Navigator.pushNamed(context, routeSameMatch);
                            },
                          );
                        } else {
                          return MatchPage(
                            flare: "assets/images/components/roulette dart.flr",
                            message: '심심할 때\n 모르는 사람들과 채팅을 해보세요.',
                            animation: "darting rl",
                            buttonColor: primaryPink,
                            buttonText: '랜덤매칭',
                            callback: () {
                              Navigator.pushNamed(context, routeRandomLoading);
                            },
                          );
                        }
                      }
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
                            itemCount: 2,
                            color: Colors.black,
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
              )
            ],
          ),
        )
      ),
    );
  }
}