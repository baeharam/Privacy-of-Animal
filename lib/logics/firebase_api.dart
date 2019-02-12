import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class FirebaseAPI {
  FirebaseAuth auth = FirebaseAuth.instance;
  Firestore firestore = Firestore.instance;

  Future<String> get user async {
    String result = await auth.currentUser().then((user) => user.uid).catchError((error)=>error);
    return result;
  }

  
}