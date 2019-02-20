import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class SettingsAPI {
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  BuildContext _context;

  // 알림 초기화
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

  Future<void> _onSelectNotification(String payload) async {
    showDialog(
      context: _context,
      builder: (_) => AlertDialog(
        title: Text('Payload'),
        content: Text('Payload: $payload'),
      )
    );
  }

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