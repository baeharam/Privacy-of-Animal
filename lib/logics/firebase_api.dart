import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:privacy_of_animal/resources/strings.dart';


class FirebaseAPI {
  FirebaseAuth _auth;
  Firestore _firestore;

  Firestore getFirestore() {
    _firestore ??= Firestore.instance;
    return _firestore;
  }

  FirebaseAuth getAuth() {
    _auth ??= FirebaseAuth.instance;
    return _auth;
  }

  Future<String> get user async {
    String result = await _auth.currentUser().then((user) => user.uid).catchError((error)=>error);
    return result;
  }

  Future<void> deleteUserAccount(String uid) async {
    CollectionReference col = _firestore.collection(firestoreDeletedUserListCollection);
    DocumentReference doc = col.document(uid);
    await _firestore.runTransaction((tx) async{
      await doc.delete();
    });
  }
}