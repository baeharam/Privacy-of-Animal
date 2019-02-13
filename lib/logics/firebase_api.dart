import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:privacy_of_animal/resources/strings.dart';


class FirebaseAPI {
  FirebaseAuth auth = FirebaseAuth.instance;
  Firestore firestore = Firestore.instance;

  Future<String> get user async {
    String result = await auth.currentUser().then((user) => user.uid).catchError((error)=>error);
    return result;
  }

  Future<void> deleteUserAccount(String uid) async {
    CollectionReference col = firestore.collection(firestoreDeletedUserListCollection);
    DocumentReference doc = col.document(uid);
    await firestore.runTransaction((tx) async{
      await doc.delete();
    });
  }
}