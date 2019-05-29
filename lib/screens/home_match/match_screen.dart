import 'package:flutter/material.dart';
import 'package:privacy_of_animal/logics/global/current_user.dart';
import 'package:privacy_of_animal/models/tag_list_model.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/screens/home_match/match_page_view.dart';
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
        body: MatchPageView()
      );
  }
}