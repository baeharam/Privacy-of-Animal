import 'dart:math';

import 'package:flutter/material.dart';

class DotsIndicator extends AnimatedWidget {
  
  final PageController pageController;
  final int itemCount;
  final ValueChanged<int> onPageSelected;
  final Color color;

  DotsIndicator({
    this.pageController,
    this.itemCount,
    this.onPageSelected,
    this.color: Colors.white
  }) : super(listenable: pageController);

  static const double _kDotSize = 8.0;
  static const double _kMaxZoom = 2.0;
  static const double _kDotSpacing = 25.0;

  /* 
    아래쪽 메뉴 점을 만드는 함수
    컨트롤러의 현재 페이지 인덱스와 점의 인덱스가 다르면 확대를 하지 않는다.
  */
  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(0.0, 1.0 - ((pageController.page ?? pageController.initialPage) - index).abs())
    );

    double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;

    return Container(
      width: _kDotSpacing,
      child: Center(
        child: Material(
          color: color,
          type: MaterialType.circle,
          child: Container(
            width: _kDotSize*zoom,
            height: _kDotSize*zoom,
            child: InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  @override
    Widget build(BuildContext context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(itemCount, _buildDot),
      );
    }
}