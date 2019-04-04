import 'package:flutter/material.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/random_loading/random_loading.dart';
import 'package:privacy_of_animal/logics/same_match/same_match.dart';
import 'package:privacy_of_animal/models/tag_list_model.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/resources/constants.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:path_drawing/path_drawing.dart';


class MatchScreen extends StatefulWidget {
  @override
  _MatchScreenState createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {

  final TagListModel tagListModel = sl.get<CurrentUser>().tagListModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '매칭하기',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: primaryBlue
      ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Image(
                width: ScreenUtil.width*0.4,
                height: ScreenUtil.height*0.3,
                image: AssetImage('assets/images/components/icon.png'),
                fit: BoxFit.fitWidth,
              ),
              
              GestureDetector(
                child: MatchingButton(
                  title: "당신의 관심사로 상대추천",
                  animation: 'Move',
                  icon: "assets/images/components/magnet.flr",
                  baseColor: primaryGreen,
                  roundColor: primaryBeige,
                ),
                onTap: () {
                  sl.get<SameMatchBloc>().emitEvent(SameMatchEventFindUser());
                  Navigator.pushNamed(context, routeSameMatch);
                },
              ),
              GestureDetector(
                child: MatchingButton(
                  title: "랜덤 추천",
                  animation: "darting rl",
                  icon: "assets/images/components/roulette dart.flr",
                  baseColor: primaryPink,
                  roundColor: primaryBeige,
                ),
                onTap: () {
                  sl.get<RandomLoadingBloc>().emitEvent(RandomLoadingEventMatchStart());
                  Navigator.pushNamed(context, routeRandomLoading);
                },
              )
            ],
          ),
        )
    );
  }
}

class MatchingButton extends StatelessWidget {
  const MatchingButton({
    Key key,
    this.animation,
    this.icon,
    this.title,
    this.baseColor,
    this.roundColor
  }) : super(key: key);

  final String title;
  final String icon;
  final String animation;
  final Color baseColor;
  final Color roundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil.width*0.9,
      height: ScreenUtil.height*0.2,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: ScreenUtil.width*0.1,
            top: ScreenUtil.height*0.03,
              child: Container(
                width: ScreenUtil.width*0.75,
                height: ScreenUtil.height*0.14,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: baseColor
                ),
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0
                    ),
                  ),
                ),
              ),
          ),
          Positioned(
            top: ScreenUtil.height*0.1-ScreenUtil.width*0.11,
            child: Container(
            height: ScreenUtil.width*0.22,
            width: ScreenUtil.width*0.22,
              decoration: BoxDecoration(
                color: roundColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 4.0
              )
            ),
              child: FlareActor(
                icon,
                alignment:Alignment.center,
                fit: BoxFit.fitWidth,
                animation: animation,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ExplainWidget extends StatelessWidget {

  final String content;

  ExplainWidget({@required this.content});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10.0,
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 1.0, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          content,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20.0
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class TagTitleForm extends StatelessWidget {
  final String content;
  final double left;
  final double top;

  TagTitleForm({
    @required this.content,
    @required this.left,
    @required this.top
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      child: GestureDetector(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              color: primaryGreen,
              width: 3.0
            ),
            color: Colors.white.withOpacity(0.2)
          ),
          child: Text(
            '# $content',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        onTap: () {
          sl.get<SameMatchBloc>().emitEvent(SameMatchEventFindUser());
          Navigator.pushNamed(context, routeSameMatch);
        }
      ),
    );
  }
}

class DashPathBorder extends Border {
  DashPathBorder({
    @required this.dashArray,
    BorderSide top = BorderSide.none,
    BorderSide left = BorderSide.none,
    BorderSide right = BorderSide.none,
    BorderSide bottom = BorderSide.none,
  }) : super(
          top: top,
          left: left,
          right: right,
          bottom: bottom,
        );

  factory DashPathBorder.all({
    BorderSide borderSide = const BorderSide(),
    @required CircularIntervalList<double> dashArray,
  }) {
    return DashPathBorder(
      dashArray: dashArray,
      top: borderSide,
      right: borderSide,
      left: borderSide,
      bottom: borderSide,
    );
  }
  final CircularIntervalList<double> dashArray;

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    TextDirection textDirection,
    BoxShape shape = BoxShape.rectangle,
    BorderRadius borderRadius,
  }) {
    if (isUniform) {
      switch (top.style) {
        case BorderStyle.none:
          return;
        case BorderStyle.solid:
          switch (shape) {
            case BoxShape.circle:
              assert(borderRadius == null,
                  'A borderRadius can only be given for rectangular boxes.');
              canvas.drawPath(
                dashPath(Path()..addOval(rect), dashArray: dashArray),
                top.toPaint(),
              );
              break;
            case BoxShape.rectangle:
              if (borderRadius != null) {
                final RRect rrect =
                    RRect.fromRectAndRadius(rect, borderRadius.topLeft);
                canvas.drawPath(
                  dashPath(Path()..addRRect(rrect), dashArray: dashArray),
                  top.toPaint(),
                );
                return;
              }
              canvas.drawPath(
                dashPath(Path()..addRect(rect), dashArray: dashArray),
                top.toPaint(),
              );

              break;
          }
          return;
      }
    }

    assert(borderRadius == null,
        'A borderRadius can only be given for uniform borders.');
    assert(shape == BoxShape.rectangle,
        'A border can only be drawn as a circle if it is uniform.');
  }
}