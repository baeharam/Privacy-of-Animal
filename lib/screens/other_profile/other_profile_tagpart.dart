import 'package:flutter/material.dart';
import 'package:privacy_of_animal/models/user_model.dart';
import 'package:privacy_of_animal/resources/constants.dart';
import 'package:privacy_of_animal/screens/other_profile/other_profile_tagform.dart';

class OtherProfileTagPart extends StatelessWidget {

  final UserModel user;
  OtherProfileTagPart({@required this.user}); 

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.only(left: ScreenUtil.width/20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                OtherProfileTagForm(content: user.tagListModel.tagTitleList[0],isTitle: true),
                SizedBox(width: 10.0),
                OtherProfileTagForm(content: user.tagListModel.tagDetailList[0],isTitle: false),
                SizedBox(width: 10.0),
                OtherProfileTagForm(content: user.tagListModel.tagTitleList[1],isTitle: true),
                SizedBox(width: 10.0),
                OtherProfileTagForm(content: user.tagListModel.tagDetailList[1],isTitle: false)
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                OtherProfileTagForm(content: user.tagListModel.tagTitleList[2],isTitle: true),
                SizedBox(width: 10.0),
                OtherProfileTagForm(content: user.tagListModel.tagDetailList[2],isTitle: false),
                SizedBox(width: 10.0),
                OtherProfileTagForm(content: user.tagListModel.tagTitleList[3],isTitle: true),
                SizedBox(width: 10.0),
                OtherProfileTagForm(content: user.tagListModel.tagDetailList[3],isTitle: false)
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                OtherProfileTagForm(content: user.tagListModel.tagTitleList[4],isTitle: true),
                SizedBox(width: 10.0),
                OtherProfileTagForm(content: user.tagListModel.tagTitleList[4],isTitle: false)
              ],
            )
          ],
        )
      ),
    );
  }
}