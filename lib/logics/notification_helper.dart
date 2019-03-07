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

  // 상대방이 친구신청을 수락했을 시 알림
  Future<void> showFriendsNotification(QuerySnapshot data) async {
    var android =AndroidNotificationDetails(
      'Friends Notification ID',
      'Friends Notification NAME',
      'Friends Notification',
      priority: Priority.High, importance: Importance.Max
    );
    var iOS =IOSNotificationDetails();
    var platform =NotificationDetails(android,iOS);

    if(data.documents.isNotEmpty && data.documentChanges.isNotEmpty 
      && sl.get<CurrentUser>().friendsList.length < data.documents.length) {
      String friendsCandidate = data.documentChanges[0].document.documentID;
      QuerySnapshot checkFriends = await sl.get<FirebaseAPI>().getFirestore()
        .collection(firestoreUsersCollection).document(sl.get<CurrentUser>().uid)
        .collection(firestoreFriendsSubCollection)
        .where(firestoreFriendsUID, isEqualTo: friendsCandidate)
        .getDocuments();
      if(checkFriends.documents.isNotEmpty){
        DocumentSnapshot userSnapshot = await sl.get<FirebaseAPI>().getFirestore()
          .collection(firestoreUsersCollection)
          .document(data.documentChanges[0].document.data[firestoreFriendsUID]).get();
        String friends = userSnapshot.data[firestoreFakeProfileField][firestoreNickNameField];
        await _flutterLocalNotificationsPlugin.show(
          0, '친구','$friends 님이 친구신청을 수락하였습니다.',platform,
          payload: '친구'
        );
      }
    }
  }

  // 상대방이 친구 신청 보냈을 시 알림
  Future<void> showFriendsRequestNotification(QuerySnapshot data) async {
    var android =AndroidNotificationDetails(
      'FriendsRequest Notification ID',
      'FriendsRequest Notification NAME',
      'FriendsRequest Notification',
      priority: Priority.High, importance: Importance.Max
    );
    var iOS =IOSNotificationDetails();
    var platform =NotificationDetails(android,iOS);

    if(data.documents.isNotEmpty && data.documentChanges.isNotEmpty 
      && sl.get<CurrentUser>().friendsRequestList.length < data.documents.length) {
      String requestCandidate = data.documentChanges[0].document.documentID;
      QuerySnapshot checkRequest = await sl.get<FirebaseAPI>().getFirestore()
        .collection(firestoreUsersCollection).document(sl.get<CurrentUser>().uid)
        .collection(firestoreFriendsSubCollection)
        .where(uidCol, isEqualTo: requestCandidate).getDocuments();
      if(checkRequest.documents.isNotEmpty){
        DocumentSnapshot userSnapshot = await sl.get<FirebaseAPI>().getFirestore()
          .collection(firestoreUsersCollection)
          .document(data.documentChanges[0].document.data[uidCol]).get();
        String sender = userSnapshot.data[firestoreFakeProfileField][firestoreNickNameField];
        await _flutterLocalNotificationsPlugin.show(
          0, '친구 신청','$sender 님으로부터 친구신청이 왔습니다.',platform,
          payload: '친구 신청 알림'
        );
      }
    }
  }
}