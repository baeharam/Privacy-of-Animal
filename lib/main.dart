import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:privacy_of_animal/resources/config.dart';
import 'package:privacy_of_animal/resources/routes.dart';
import 'package:privacy_of_animal/screens/main/intro_screen.dart';

Future<void> main() async{
  final FirebaseApp app = await FirebaseApp.configure(
    name: '동물의 사생활',
    options: const FirebaseOptions(
      googleAppID: androidAppID,
      apiKey: apiKey,
      projectID: projectID
    )
  );
  final Firestore firestore = Firestore(app: app);
  await firestore.settings(timestampsInSnapshotsEnabled: true);
  runApp(PrivacyOfAnimal());
}

class PrivacyOfAnimal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '동물의 사생활',
      home: IntroScreen(),
      theme: ThemeData(
        splashColor: Colors.transparent,
        fontFamily: 'NanumGothic'
      ),
      routes: routes,
      debugShowCheckedModeBanner: false
    );
  }
}