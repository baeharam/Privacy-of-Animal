import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state_builder.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/photo/photo.dart';
import 'package:privacy_of_animal/logics/tag_edit/tag_edit.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/resources/constants.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/utils/stream_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final CurrentUser _user = sl.get<CurrentUser>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: ScreenUtil.width/20,right: ScreenUtil.width/20,bottom: ScreenUtil.height/20),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: ScreenUtil.height/20),
                    child: Row(
                      children: <Widget>[
                        Text(
                          '가상프로필',
                          style: primaryTextStyle,
                        ),
                        GestureDetector(
                          child: Image(
                            image: AssetImage('assets/images/components/modify.png'),
                            width: 50.0,
                            height: 50.0,
                          ),
                          onTap: (){
                            sl.get<PhotoBloc>().emitEvent(PhotoEventReset());
                            Navigator.pushNamed(context, routePhotoDecision);
                          }
                        )
                      ],
                    )
                  ),
                  SizedBox(height: 10.0),
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                    elevation: 5.0,
                    color: primaryGreen,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.0,top: 10.0,bottom: 10.0),
                      child: Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  CircularPercentIndicator(
                                    radius: ScreenUtil.width/2.8,
                                    percent: _user.fakeProfileModel.animalConfidence,
                                    lineWidth: 10.0,
                                  ),
                                  CircleAvatar(
                                    backgroundImage: AssetImage(_user.fakeProfileModel.animalImage),
                                    radius: ScreenUtil.width/6.2,
                                  )
                                ],
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                _user.fakeProfileModel.nickName,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          ),
                          SizedBox(width: 20.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              FakeProfileForm(title: '추정동물',detail: _user.fakeProfileModel.animalName),
                              FakeProfileForm(title: '추정성별',detail: _user.fakeProfileModel.gender),
                              FakeProfileForm(title: '추정나이',detail: _user.fakeProfileModel.age),
                              FakeProfileForm(title: '추정기분',detail: _user.fakeProfileModel.emotion)
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            ),
            Container(
              color: Colors.grey.withOpacity(0.2),
              width: double.infinity,
              height: 10.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtil.width/20,vertical: ScreenUtil.height/20),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      '실제프로필',
                      style: primaryTextStyle,
                    ),
                  ),
                  Text(
                    '수정 불가하며, 친구가 될시 공개됩니다.',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0
                    ),
                  ),
                  SizedBox(height: 10.0),
                  RealProfileForm(title: '실제이름',detail: _user.realProfileModel.name),
                  RealProfileForm(title: '실제성별',detail: _user.realProfileModel.gender),
                  RealProfileForm(title: '실제나이',detail: _user.realProfileModel.age),
                  RealProfileForm(title: '실제직업',detail: _user.realProfileModel.job)
                ],
              )
            ),
            Container(
              color: Colors.grey.withOpacity(0.2),
              width: double.infinity,
              height: 10.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtil.width/20,vertical: ScreenUtil.height/20),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      '관심사 태그',
                      style: primaryTextStyle,
                    )
                  ),
                  SizedBox(height: 10.0),
                  TagPart()
                ],
              )
            ),
          ],
        )
      )
    );  
  }
}


class TagPart extends StatefulWidget {
  @override
  _TagPartState createState() => _TagPartState();
}

class _TagPartState extends State<TagPart> {
  @override
  Widget build(BuildContext context) {

    final CurrentUser _user = sl.get<CurrentUser>();
    final TagEditBloc _tagEditBloc = sl.get<TagEditBloc>();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.only(left: ScreenUtil.width/20),
        child: BlocBuilder(
          bloc: _tagEditBloc,
          builder: (context, TagEditState state){
            if(state.isShowDialog){
              streamDialogEditTag(context,state.tagIndex,state.dropDownItems);
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    GestureDetector(
                      child: TagForm(content: _user.tagListModel.tagTitleList[0],isTitle: true),
                      onTap: () => _tagEditBloc.emitEvent(TagEditEventClick(tagIndex: 0))
                    ),
                    SizedBox(width: 10.0),
                    GestureDetector(
                      child: TagForm(content: _user.tagListModel.tagDetailList[0],isTitle: false),
                      onTap: () => _tagEditBloc.emitEvent(TagEditEventClick(tagIndex: 0))
                    ),
                    SizedBox(width: 10.0),
                    GestureDetector(
                      child: TagForm(content: _user.tagListModel.tagTitleList[1],isTitle: true),
                      onTap: () => _tagEditBloc.emitEvent(TagEditEventClick(tagIndex: 1))
                    ),
                    SizedBox(width: 10.0),
                    GestureDetector(
                      child: TagForm(content: _user.tagListModel.tagDetailList[1],isTitle: false),
                      onTap: () => _tagEditBloc.emitEvent(TagEditEventClick(tagIndex: 1))
                    )
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    GestureDetector(
                      child: TagForm(content: _user.tagListModel.tagTitleList[2],isTitle: true),
                      onTap: () => _tagEditBloc.emitEvent(TagEditEventClick(tagIndex: 2))
                    ),
                    SizedBox(width: 10.0),
                    TagForm(content: _user.tagListModel.tagDetailList[2],isTitle: false),
                    SizedBox(width: 10.0),
                    TagForm(content: _user.tagListModel.tagTitleList[3],isTitle: true),
                    SizedBox(width: 10.0),
                    TagForm(content: _user.tagListModel.tagDetailList[3],isTitle: false)
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    TagForm(content: _user.tagListModel.tagTitleList[4],isTitle: true),
                    SizedBox(width: 10.0),
                    TagForm(content: _user.tagListModel.tagDetailList[4],isTitle: false)
                  ],
                )
              ],
            );
          }
        )
      ),
    );
  }

  
}

class FakeProfileForm extends StatelessWidget {

  final String title;
  final String detail;

  FakeProfileForm({
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

class RealProfileForm extends StatelessWidget {

  final String title;
  final String detail;

  RealProfileForm({
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
          text: detail
        )]
      )
    );
  }
}

class TagForm extends StatelessWidget {
  final String content;
  final bool isTitle;
  TagForm({@required this.content, @required this.isTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: isTitle ? primaryBlue : primaryGreen,
          width: 3.0
        )
      ),
      child: Text(
        '# $content'
      ),
    );
  }
}