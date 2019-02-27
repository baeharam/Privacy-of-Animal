import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/resources/strings.dart';

class NotificationHelper {
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  BuildContext _context;

  // Notification 세팅/초기화
  void initializeNotification(BuildContext context) {
    var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsiOS =IOSInitializationSettings();

    var initializationSettings =InitializationSettings(
      initializationSettingsAndroid, initializationSettingsiOS
    );

    this._context = context;

    _flutterLocalNotificationsPlugin =FlutterLocalNotificationsPlugin();
    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: _onSelectNotification);
  }

  // Notification 눌렀을 때 나오는 메시지
  Future<void> _onSelectNotification(String payload) async {
    showDialog(
      context: _context,
      builder: (_) => AlertDialog(
        title: Text('Payload'),
        content: Text('Payload: $payload'),
      )
    );
  }

  // Notification 메시지
  Future<void> showFriendsRequestNotification(DocumentSnapshot friendsRequest) async {
    var android =AndroidNotificationDetails(
      'FriendsRequest Notification ID',
      'FriendsRequest Notification NAME',
      'FriendsRequest Notification',
      priority: Priority.High, importance: Importance.Max
    );
    var iOS =IOSNotificationDetails();
    var platform =NotificationDetails(android,iOS);

    if(sl.get<CurrentUser>().friendsRequestList.contains(friendsRequest)){
      String sender = friendsRequest.data[firestoreFakeProfileField][firestoreNickNameField];

      await _flutterLocalNotificationsPlugin.show(
        0, '친구 신청','$sender 님으로부터 친구신청이 왔습니다.',platform,
        payload: '친구 신청 알림'
      );
    }
  }
}