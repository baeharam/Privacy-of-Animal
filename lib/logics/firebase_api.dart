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

  Future<void> deleteUser(String uid) async {
    CollectionReference col = await firestore.collection(firestoreDeletedUserListCollection);
    await firestore.runTransaction((tx) async{
      DocumentSnapshot snapshot = await tx.get(col.document(uid));
      if(snapshot.exists){
        await tx.set(snapshot.reference, {'delete': true});
      }
    });
  }
}