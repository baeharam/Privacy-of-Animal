import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';

// 원 코드 출처 =  https://gist.github.com/collinjackson/50172e3547e959cba77e2938f2fe5ff5

class EnsureVisibleWhenFocused extends StatefulWidget {
  const EnsureVisibleWhenFocused({
    Key key,
    @required this.child,
    @required this.focusNode,
    this.curve: Curves.ease,
    this.duration: const Duration(milliseconds: 20),
  }) : super(key: key);

  final FocusNode focusNode;
  final Widget child;
  final Curve curve;
  final Duration duration;

  @override
  _EnsureVisibleWhenFocusedState createState() => new _EnsureVisibleWhenFocusedState();
}

/// window metrics에 변화가 생기는 것을 감지하기 위해서 WidgetsBindingObserver를 사용한다.
class _EnsureVisibleWhenFocusedState extends State<EnsureVisibleWhenFocused> with WidgetsBindingObserver  {

  @override
  void initState(){
    super.initState();
    widget.focusNode.addListener(_ensureVisible);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose(){
    WidgetsBinding.instance.removeObserver(this);
    widget.focusNode.removeListener(_ensureVisible);
    super.dispose();
  }

  /// window metrics 변화감지, 포커스 되어있으면 해당 위젯 보이게 하는 기능
  @override
  void didChangeMetrics(){
    if (widget.focusNode.hasFocus){
      _ensureVisible();
    }
  }

  /// 키보드 열렸나 감지
  Future<Null> _keyboardToggled() async {
    if (mounted){
      EdgeInsets edgeInsets = MediaQuery.of(context).viewInsets;
      while (mounted && MediaQuery.of(context).viewInsets == edgeInsets) {
        await new Future.delayed(const Duration(milliseconds: 10));
      }
    }
    return;
  }

  Future<Null> _ensureVisible() async {
    // 키보드 열릴 때까지 기다림
    await Future.any([new Future.delayed(const Duration(milliseconds: 300)), _keyboardToggled()]);

    // 포커스 없으면 중단
    if (!widget.focusNode.hasFocus){
      return;
    }

    // 포커싱 잡힌 RenderObject 찾아냄
    // 그 후 RenderObject를 이용해서 viewport 얻어냄
    final RenderObject object = context.findRenderObject();
    final RenderAbstractViewport viewport = RenderAbstractViewport.of(object);

    // 스크롤이 되는 위젯을 사용하지 않는 경우이므로 중단
    if (viewport == null) {
        return;
    }

    // 스크롤 상태 획득
    ScrollableState scrollableState = Scrollable.of(context);
    assert(scrollableState != null);

    // 획득한 스크롤 상태를 통해 현재 스크롤 위치 획득
    ScrollPosition position = scrollableState.position;
    double alignment;

    // 현재 스크롤 위치가 타겟이 보일 수 있는 위치보다 큰 경우
    // 해당 타겟이 보일 수 있게 내림.
    if (position.pixels > viewport.getOffsetToReveal(object, 0.0).offset) {
      alignment = 0.2;
    } 
    // 현재 스크롤 위치가 타겟이 보일 수 있는 위치보다 작은 경우
    // 해당 타겟이 보일 수 있게 올림.
    else if (position.pixels < viewport.getOffsetToReveal(object, 0.2).offset){
      alignment = 0.2;
    } 
    // 타겟이 보이면 스크롤 할 필요 없음.
    else {
      return;
    }

    position.ensureVisible(
      object,
      alignment: alignment,
      duration: widget.duration,
      curve: widget.curve,
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}