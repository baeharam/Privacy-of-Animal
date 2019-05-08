import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/logics/random_chat/random_chat.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class BackButtonAction {
  static DateTime currentBackPressTime;

  static Future<bool> oneMorePressToExit(BuildContext context, ScaffoldState state) {
    DateTime now = DateTime.now();
    if(now.difference(currentBackPressTime) > Duration(seconds: 1)){
      currentBackPressTime = now;
      state.showSnackBar(SnackBar(content: Text('한번 더 누르시면 종료됩니다.'),duration: const Duration(milliseconds: 300)));
      return Future.value(false);
    }
    return Future.value(true);
  }

  static Future<bool> stopInMiddle(BuildContext context) async{
    Alert(
      title: '중단하시겠습니까?',
      type: AlertType.warning,
      context: context,
      content: Text(
        '자동으로 로그아웃 됩니다.'
      ),
      buttons: [
        DialogButton(
          color: Colors.red,
          child: Text(
            '예',
            style: TextStyle(
              color: Colors.white
            ),
          ),
          onPressed: () async {
            await sl.get<FirebaseAPI>().getAuth().signOut();
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          },
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
    return Future.value(false);
  }

  static Future<bool> terminateApp(BuildContext context) async{
    Alert(
      title: '종료하시겠습니까?',
      type: AlertType.warning,
      context: context,
      content: Text(
        '자동으로 로그아웃 됩니다.'
      ),
      buttons: [
        DialogButton(
          color: Colors.red,
          child: Text(
            '예',
            style: TextStyle(
              color: Colors.white
            ),
          ),
          onPressed: () async {
            await sl.get<FirebaseAPI>().getAuth().signOut();
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          },
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
    return Future.value(false);
  }

  static Future<bool> dialogChatExit(BuildContext context, String chatRoomID) {

    final randomChatBloc = sl.get<RandomChatBloc>();

    Alert(
      context: context,
      title: '채팅을 종료하시겠습니까?',
      type: AlertType.warning,
      buttons: [
        DialogButton(
          onPressed: (){
            randomChatBloc.emitEvent(RandomChatEventOut(chatRoomID: chatRoomID));
          },
          child: Text(
            '예',
            style: TextStyle(
              color: Colors.white
            ),
          ),
          color: primaryPink,
        ),
        DialogButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            '아니오',
            style: TextStyle(
              color: Colors.white
            ),
          ),
          color: primaryBeige,
        )
      ]
    ).show();

    return Future.value(false);
  }
}