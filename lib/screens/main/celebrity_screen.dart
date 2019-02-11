import 'package:flutter/material.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';

class CelebrityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '네이버 검색 결과',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        leading: Container(),
        elevation: 0.0,
        backgroundColor: primaryBlue,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        scrollDirection: Axis.vertical,
        children: [
          Image.network(sl.get<CurrentUser>().celebrityUrls[0]),
          Image.network(sl.get<CurrentUser>().celebrityUrls[1]),
          Image.network(sl.get<CurrentUser>().celebrityUrls[2]),
          Image.network(sl.get<CurrentUser>().celebrityUrls[3]),
          Image.network(sl.get<CurrentUser>().celebrityUrls[4]),
          Image.network(sl.get<CurrentUser>().celebrityUrls[5])
        ],
      ),
    );
  }
}
