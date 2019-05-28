import 'package:flutter/material.dart';
import 'package:privacy_of_animal/models/real_profile_model.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/resources/constants.dart';

class ProfileRealPart extends StatelessWidget {

  final RealProfileModel realProfileModel;

  const ProfileRealPart({Key key, @required this.realProfileModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        elevation: 5.0,
        color: primaryPink.withOpacity(0.9),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Row(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                width: ScreenUtil.width/3.5,
                height: ScreenUtil.width/3.5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white,width: 2.0),
                ),
                child: Text(
                  '?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold
                  ),
                )
              ),
              SizedBox(width: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ProfileRealElement(title: '실제이름',detail: realProfileModel.name),
                  ProfileRealElement(title: '실제성별',detail: realProfileModel.gender),
                  ProfileRealElement(title: '실제나이',detail: realProfileModel.age),
                  ProfileRealElement(title: '실제직업',detail: realProfileModel.job),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileRealElement extends StatelessWidget {

  final String title;
  final String detail;

  ProfileRealElement({
    @required this.title,
    @required this.detail
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '$title  ',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20.0
        ),
        children: [TextSpan(
          text: detail,
          style: TextStyle(color: Colors.white)
        )]
      )
    );
  }
}