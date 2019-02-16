import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state_builder.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/friend_request/friend_request.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/resources/constants.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/utils/stream_snackbar.dart';

class OtherProfileScreen extends StatefulWidget {

  final DocumentSnapshot user;

  OtherProfileScreen({@required this.user});  

  @override
  _OtherProfileScreenState createState() => _OtherProfileScreenState();
}

class _OtherProfileScreenState extends State<OtherProfileScreen> {

  bool isFriend;

  @override
  void initState() {
    super.initState();
    isFriend = (widget.user.data[firestoreFriendsField] as List)
    .contains(sl.get<CurrentUser>().uid);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '프로필',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: primaryBlue,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: (){},
          )
        ],
      ),
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
                        Spacer(),
                        GestureDetector(
                          child: Row(
                            children: <Widget>[
                              Text(
                                '닮은 유명인 보기',
                                style: TextStyle(
                                  color: primaryBlue,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Icon(Icons.search)
                            ],
                          ),
                          onTap: () => Navigator.push(context, MaterialPageRoute(
                            builder: (context) => 
                              webViewImage(widget.user.data[firestoreFakeProfileField]
                                [firestoreCelebrityField])
                          )),
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
                                    percent: widget.user.data[firestoreFakeProfileField][firestoreAnimalConfidenceField],
                                    lineWidth: 10.0,
                                    progressColor: primaryBeige,
                                  ),
                                  CircleAvatar(
                                    backgroundImage: AssetImage(widget.user.data[firestoreFakeProfileField]
                                      [firestoreAnimalImageField]),
                                    radius: ScreenUtil.width/6.2,
                                  )
                                ],
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                widget.user.data[firestoreFakeProfileField][firestoreNickNameField],
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
                              OtherFakeProfileForm(title: '추정동물',detail: widget.user.data[firestoreFakeProfileField][firestoreAnimalNameField]),
                              OtherFakeProfileForm(title: '추정성별',detail: widget.user.data[firestoreFakeProfileField][firestoreFakeGenderField]),
                              OtherFakeProfileForm(title: '추정나이',detail: widget.user.data[firestoreFakeProfileField][firestoreFakeAgeField]),
                              OtherFakeProfileForm(title: '추정기분',detail: widget.user.data[firestoreFakeProfileField][firestoreFakeEmotionField]),
                              OtherFakeProfileForm(title: '유명인   ',detail: widget.user.data[firestoreFakeProfileField][firestoreCelebrityField])
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
              child: isFriend ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      '실제프로필',
                      style: primaryTextStyle,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  OtherRealProfileForm(title: '이름',detail: widget.user.data[firestoreRealProfileField][firestoreNameField]),
                  OtherRealProfileForm(title: '성별',detail: widget.user.data[firestoreRealProfileField][firestoreGenderField]),
                  OtherRealProfileForm(title: '나이',detail: widget.user.data[firestoreRealProfileField][firestoreAgeField]),
                  OtherRealProfileForm(title: '직업',detail: widget.user.data[firestoreRealProfileField][firestoreJobField])
                ],
              ) 
              : Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.lock),
                      SizedBox(width: 10.0),
                      Text(
                        '실제 프로필은 친구가 될시 공개됩니다.',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ]
                  ),
                  SizedBox(height: 10.0),
                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: primaryBlue,
                        border: Border.all(color: primaryBlue),
                        borderRadius: BorderRadius.circular(3.0)
                      ),
                      child: Text(
                        '친구신청 하기',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    onTap: () => sl.get<FriendRequestBloc>()
                      .emitEvent(FriendRequestEventSendRequest(uid: widget.user.documentID)),
                  )
                ]
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
                  SizedBox(height: 20.0),
                  OtherTagPart(user: widget.user)
                ],
              )
            ),
            BlocBuilder(
              bloc: sl.get<FriendRequestBloc>(),
              builder: (context, FriendRequestState state){
                if(state.isSucceeded){
                  streamSnackbar(context, '친구신청에 성공하였습니다.');
                  sl.get<FriendRequestBloc>().emitEvent(FriendRequestEventStateClear());
                } else if(state.isFailed){
                  streamSnackbar(context, '친구신청에 실패하였습니다.');
                  sl.get<FriendRequestBloc>().emitEvent(FriendRequestEventStateClear());
                }
                return Container();
              },
            )
          ],
        )
      )
    );  
  }
}

class OtherTagPart extends StatelessWidget {

  final DocumentSnapshot user;
  OtherTagPart({@required this.user}); 

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
                OtherTagForm(content: user.data[firestoreTagField][firestoreTagTitle1Field],isTitle: true),
                SizedBox(width: 10.0),
                OtherTagForm(content: user.data[firestoreTagField][firestoreTagDetail1Field],isTitle: false),
                SizedBox(width: 10.0),
                OtherTagForm(content: user.data[firestoreTagField][firestoreTagTitle2Field],isTitle: true),
                SizedBox(width: 10.0),
                OtherTagForm(content: user.data[firestoreTagField][firestoreTagDetail2Field],isTitle: false)
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                OtherTagForm(content: user.data[firestoreTagField][firestoreTagTitle3Field],isTitle: true),
                SizedBox(width: 10.0),
                OtherTagForm(content: user.data[firestoreTagField][firestoreTagDetail3Field],isTitle: false),
                SizedBox(width: 10.0),
                OtherTagForm(content: user.data[firestoreTagField][firestoreTagTitle4Field],isTitle: true),
                SizedBox(width: 10.0),
                OtherTagForm(content: user.data[firestoreTagField][firestoreTagDetail4Field],isTitle: false)
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                OtherTagForm(content: user.data[firestoreTagField][firestoreTagTitle5Field],isTitle: true),
                SizedBox(width: 10.0),
                OtherTagForm(content: user.data[firestoreTagField][firestoreTagDetail5Field],isTitle: false)
              ],
            )
          ],
        )
      ),
    );
  }
}

class OtherFakeProfileForm extends StatelessWidget {

  final String title;
  final String detail;

  OtherFakeProfileForm({
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

class OtherRealProfileForm extends StatelessWidget {

  final String title;
  final String detail;

  OtherRealProfileForm({
    @required this.title,
    @required this.detail
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
      child: Row(
        children: <Widget>[
          Text(
            '*'+title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15.0
            ),
          ),
          Spacer(),
          Text(
            detail,
            style: TextStyle(
              fontSize: 15.0
            ),
          )
        ],
      ),
    );
  }
}

class OtherTagForm extends StatelessWidget {
  final String content;
  final bool isTitle;
  OtherTagForm({@required this.content, @required this.isTitle});

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