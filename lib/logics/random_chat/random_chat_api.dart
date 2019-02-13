import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';

class RandomChatAPI {
  Future<void> setRandomUser() async {
    CollectionReference col = sl.get<FirebaseAPI>().firestore.collection(firestoreRandomChatCollection);
    DocumentReference doc = col.document(sl.get<CurrentUser>().uid);
    Random random = Random();
    int randomValue = random.nextInt(pow(2,32));

    await sl.get<FirebaseAPI>().firestore.runTransaction((transaction) async{
      await doc.setData({
        firestoreRandom: randomValue,
        uidCol: sl.get<CurrentUser>().uid
      }, merge: true);
    });
  }

  Future<void> updateUsers(String user) async {
    CollectionReference col = sl.get<FirebaseAPI>().firestore.collection(firestoreRandomChatCollection);
    DocumentReference user1 = col.document(sl.get<CurrentUser>().uid);
    DocumentReference user2 = col.document(user);
    await sl.get<FirebaseAPI>().firestore.runTransaction((transaction) async{
      await user1.delete();
      await user2.delete();
    });
  }

  Future<void> deleteUser() async {
    CollectionReference col = sl.get<FirebaseAPI>().firestore.collection(firestoreRandomChatCollection);
    DocumentReference user = col.document(sl.get<CurrentUser>().uid);
    await sl.get<FirebaseAPI>().firestore.runTransaction((transaction) async{
      await user.delete();
    });
  }
}