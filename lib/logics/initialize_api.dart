import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:privacy_of_animal/resources/config.dart';
import 'package:privacy_of_animal/resources/constants.dart';

class InitializeAPI {

  // 앱 시작 초기화
  Future<void> appInitialize() async {
    await FirebaseApp.configure(
      name: 'Privacy of Animal',
      options: const FirebaseOptions(
        googleAppID: androidAppID,
        apiKey: appAPIKey,
        projectID: projectID
      )
    );
    await Firestore.instance.settings(timestampsInSnapshotsEnabled: true);
  }

  // 상수값 초기화
  void constantInitialize(BuildContext context) {
    ScreenUtil.width = MediaQuery.of(context).size.width;
    ScreenUtil.height = MediaQuery.of(context).size.height;
    CurrentPlatform.platform = Theme.of(context).platform;
  }
}