import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/resources/strings.dart';

class FriendRequestAPI {

  Future<void> requestFriend(String uid) async {
    DocumentReference doc = 
     sl.get<FirebaseAPI>().getFirestore().collection(firestoreUsersCollection)
      .document(uid);

    await sl.get<FirebaseAPI>().getFirestore().runTransaction((tx) async{
      await tx.update(doc, {
        firestoreFriendsRequestField: FieldValue.arrayUnion([sl.get<CurrentUser>().uid])
      });
    });
  }

}