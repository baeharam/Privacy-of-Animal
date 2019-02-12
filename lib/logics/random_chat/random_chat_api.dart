import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';

class RandomChatAPI {
  Future<void> setRandomUser() async {
    CollectionReference col = sl.get<FirebaseAPI>().firestore.collection(firestoreRandomChatCollection);
    Random random = Random();
    int randomValue = random.nextInt(pow(2,32));

    await sl.get<FirebaseAPI>().firestore.runTransaction((transaction) async{
      col.document(sl.get<CurrentUser>().uid).setData({
        'random': randomValue
      });
    });
  }

  Stream getDocumentStream() {
    int randomValue = Random().nextInt(pow(2,32));
    CollectionReference col = sl.get<FirebaseAPI>().firestore.collection(firestoreRandomChatCollection);
    Query query = col.where('random',isGreaterThan: randomValue).orderBy('random').limit(1);
    return query.snapshots();
  }

  Future<void> updateUsers(String uid1, String uid2) async {
    CollectionReference col = sl.get<FirebaseAPI>().firestore.collection(firestoreRandomChatCollection);
    await sl.get<FirebaseAPI>().firestore.runTransaction((transaction) async{
      await col.document(uid1).delete();
      await col.document(uid2).delete();
    });
  }
}