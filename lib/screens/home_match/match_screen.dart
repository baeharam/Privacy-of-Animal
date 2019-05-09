import 'package:flutter/material.dart';
import 'package:privacy_of_animal/logics/global/current_user.dart';
import 'package:privacy_of_animal/logics/same_match/same_match.dart';
import 'package:privacy_of_animal/models/tag_list_model.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/resources/constants.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/screens/home_match/match_button.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';

class MatchScreen extends StatelessWidget {
  
  final TagListModel tagListModel = sl.get<CurrentUser>().tagListModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              '매칭하기',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: primaryBlue),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisSize: MainAxisSize.min,
              children: [
                Image(
                  width: ScreenUtil.width * 0.4,
                  height: ScreenUtil.height * 0.3,
                  image: AssetImage('assets/images/components/icon.png'),
                  fit: BoxFit.fitWidth,
                ),
                GestureDetector(
                  child: MatchButton(
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
                  child: MatchButton(
                    title: "랜덤 매칭",
                    animation: "darting rl",
                    icon: "assets/images/components/roulette dart.flr",
                    baseColor: primaryPink,
                    roundColor: primaryBeige,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, routeRandomLoading);
                  },
                )
              ],
            ),
          ),
        ));
  }
}