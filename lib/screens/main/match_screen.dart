import 'package:flutter/material.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/random_loading/random_loading.dart';
import 'package:privacy_of_animal/logics/same_match/same_match.dart';
import 'package:privacy_of_animal/models/tag_list_model.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/resources/constants.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';

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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage('assets/images/components/match_random_circle.png'),
              width: ScreenUtil.width * 1.1,
              height: ScreenUtil.width * 1.1,
            ),

            SizedBox(
              height: ScreenUtil.height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  child: Text("상대 추천"),
                  onPressed: null,
                ),
                FlatButton(
                  child: Text("랜덤 매칭"),
                  onPressed: null,
                )
              ],
            )
          ],
        )
//      body: Stack(
//        children: <Widget>[
//          Positioned(
//            top: -ScreenUtil.height/10,
//            left: -ScreenUtil.width/2,
//            child: GestureDetector(
//              child: Image(
//                image: AssetImage('assets/images/components/match_tag_circle.png'),
//                width: ScreenUtil.width*1.1,
//                height: ScreenUtil.width*1.1
//              ),
//              onTap: () {
//                sl.get<SameMatchBloc>().emitEvent(SameMatchEventFindUser());
//                Navigator.pushNamed(context, routeSameMatch);
//              },
//            ),
//          ),
//          TagTitleForm(
//            content: tagListModel.tagTitleList[0],
//            left: ScreenUtil.width/7,
//            top: ScreenUtil.height/15,
//          ),
//          TagTitleForm(
//            content: tagListModel.tagTitleList[1],
//            left: ScreenUtil.width/12,
//            top: ScreenUtil.height/8,
//          ),
//          TagTitleForm(
//            content: tagListModel.tagTitleList[2],
//            left: ScreenUtil.width/13,
//            top: ScreenUtil.height/5.5,
//          ),
//          TagTitleForm(
//            content: tagListModel.tagTitleList[3],
//            left: ScreenUtil.width/11,
//            top: ScreenUtil.height/4,
//          ),
//          TagTitleForm(
//            content: tagListModel.tagTitleList[4],
//            left: ScreenUtil.width/15,
//            top: ScreenUtil.height/3.2,
//          ),
//          Positioned(
//            left: ScreenUtil.width/3,
//            top: ScreenUtil.height/6,
//            child: ExplainWidget(
//              content: '관심사 일치\n대화상대 추천'
//            ),
//          ),
//          Positioned(
//            bottom: -ScreenUtil.height/7,
//            right: -ScreenUtil.width/2,
//            child: GestureDetector(
//              child: Image(
//                width: ScreenUtil.width*1.1,
//                height: ScreenUtil.width*1.1,
//                image: AssetImage('assets/images/components/match_random_circle.png'),
//              ),
//              onTap: () {
//                sl.get<RandomLoadingBloc>().emitEvent(RandomLoadingEventMatchStart());
//                Navigator.pushNamed(context, routeRandomLoading);
//              }
//            )
//          ),
//          Positioned(
//            right: ScreenUtil.width/4,
//            bottom: ScreenUtil.height/6,
//            child: ExplainWidget(
//              content: '완전 랜덤 매칭'
//            ),
//          ),
//        ],
//      )
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