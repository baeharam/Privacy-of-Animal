import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state_builder.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/login/login.dart';
import 'package:privacy_of_animal/logics/setting/setting.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/resources/resources.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:privacy_of_animal/utils/bloc_navigator.dart';
import 'package:privacy_of_animal/utils/bloc_snackbar.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SettingScreen extends StatefulWidget {

  @override
  SettingScreenState createState() => SettingScreenState();
}

class SettingScreenState extends State<SettingScreen> {
  final CurrentUser _user =sl.get<CurrentUser>();
  final List<SettingItem> items = SettingItem.items();
  final SettingBloc settingBloc = sl.get<SettingBloc>();

  void _reallyDelteAccount() {
    Alert(
      title: '정말로 탈퇴하시겠습니까?',
      type: AlertType.error,
      context: context,
      content: Text(
        '모든 정보가 삭제됩니다.'
      ),
      buttons: [
        DialogButton(
          child: Text(
            '예',
            style: TextStyle(
              color: Colors.white
            ),
          ),
          color: Colors.red,
          onPressed: () {
            settingBloc.emitEvent(SettingEventGetOut());
            Navigator.of(context).pop();
          }
        ),
        DialogButton(
          child: Text(
            '아니오',
            style: TextStyle(
              color: Colors.white
            ),
          ),
          onPressed: () => Navigator.of(context).pop()
        )
      ]
    ).show();
  }

  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "설정",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        backgroundColor: primaryBlue,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            //위에 개인
            Container(
              padding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 10.0),
              child: Row(
                children: <Widget>[
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      CircularPercentIndicator(
                        radius: ScreenUtil.width*0.2,
                        percent: _user.fakeProfileModel.animalConfidence,
                        lineWidth: 4.3,
                        progressColor: primaryBeige,
                      ),
                      CircleAvatar(
                        backgroundImage: AssetImage(_user.fakeProfileModel.animalImage),
                        radius: ScreenUtil.width*0.09,
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10.0),
                    width: ScreenUtil.width*0.47,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _user.fakeProfileModel.nickName,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 17.0
                          ),
                          ),
                      ],
                    ),
                  ),
                  BlocBuilder(
                    bloc: settingBloc,
                    builder: (context, SettingState state){
                      if(state.isLogoutLoading){
                        return CircularProgressIndicator();
                      }
                      if(state.isLogoutSucceeded){
                        BlocNavigator.pushNamedAndRemoveAll(context, routeIntro);
                        sl.get<LoginBloc>().emitEvent(LoginEventStateClear());
                        settingBloc.emitEvent(SettingEventStateClear());
                      }
                      if(state.isLogoutFailed){
                        BlocSnackbar.show(context, '로그아웃에 실패했습니다.');
                        settingBloc.emitEvent(SettingEventStateClear());
                      }
                      return ButtonTheme(
                        minWidth: ScreenUtil.width*0.1,
                        child: RaisedButton(
                          onPressed: () => settingBloc.emitEvent(SettingEventLogOut()),
                          color: primaryBeige,
                          textColor: primaryBlue,
                          child: Text("로그아웃",style: TextStyle(fontWeight: FontWeight.w800),),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0)
                          ),
                        ),
                      );
                    }
                  )
                ],
              ),
            ),  
            Container(
              height: ScreenUtil.height*0.014,
              color: Colors.grey[300],
            ),
            Flexible(
              fit: FlexFit.tight,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index){
                  return Container(
                    child: ListTile(
                      title: Text(
                        items[index].title,
                        style: TextStyle(
                          fontSize: items[index].titleSize,
                          fontWeight: items[index].fontWeight,
                          color: items[index].titleColor
                        ),
                        ),
                      onTap :() {
                        if(index==0){
                          Navigator.pushNamed(context, routeNotification);
                        }
                        else if(index==3){
                          _reallyDelteAccount();
                        }
                      },
                      trailing: Icon(items[index].trailing),
                    ),
                    padding: EdgeInsets.only(left: ScreenUtil.width*0.07, right: ScreenUtil.width*0.07),
                    foregroundDecoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey[300],width: 1.5)
                      )
                    ),
                  );
                },
              ),
            ),
            BlocBuilder(
              bloc: settingBloc,
              builder: (context, SettingState state){
                if(state.isGetoutLoading){
                  return Container(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    alignment: Alignment.bottomCenter,
                    child: CircularProgressIndicator()
                  );
                }
                if(state.isGetoutFailed){
                  BlocSnackbar.show(context, '회원탈퇴에 실패했습니다.');
                  settingBloc.emitEvent(SettingEventStateClear());
                }
                if(state.isGetoutSucceeded){
                  BlocNavigator.pushNamedAndRemoveAll(context, routeIntro);
                  sl.get<LoginBloc>().emitEvent(LoginEventStateClear());
                  settingBloc.emitEvent(SettingEventStateClear());
                }
                return Container();
              },
            )
          ],
        ),
      )
    );
  } 
}


class SettingItem {
  final String title;
  final String routeName;
  final double titleSize;
  final Color titleColor;
  final FontWeight fontWeight;
  final IconData trailing;
  SettingItem({
    this.title,
    this.routeName,
    this.titleSize,
    this.titleColor,
    this.fontWeight,
    this.trailing

  });

  static List<SettingItem> items(){
    var box = new List<SettingItem>();
    box.add(new SettingItem(title: '서비스 이용안내', routeName:"", titleSize: 14.0, titleColor: Colors.black, fontWeight: FontWeight.w600, trailing: Icons.keyboard_arrow_right));
    box.add(new SettingItem(title: '이용약관', routeName: "", titleSize: 14.0, titleColor: Colors.black, fontWeight: FontWeight.w600, trailing: Icons.keyboard_arrow_right));
    box.add(new SettingItem(title: '개인정보 처리방침',routeName:"", titleSize: 14.0, titleColor: Colors.black, fontWeight: FontWeight.w600, trailing: Icons.keyboard_arrow_right));
    box.add(new SettingItem(title: '회원탈퇴',routeName: "", titleSize: 15.0, titleColor: Colors.redAccent, fontWeight: FontWeight.w800, trailing: null));
    return box;
  }
}