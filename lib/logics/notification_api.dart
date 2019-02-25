import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationAPI {
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
  Future<void> showNotification() async {
    var android =AndroidNotificationDetails(
      'channel id','channel NAME','CHANNEL DESCRIPTION',
      priority: Priority.High, importance: Importance.Max
    );
    var iOS =IOSNotificationDetails();
    var platform =NotificationDetails(android,iOS);
    await _flutterLocalNotificationsPlugin.show(
      0, '친구 신청이 왔습니다','플러터 알림',platform,
      payload: '친구 신청 알림'
    );
  }
}