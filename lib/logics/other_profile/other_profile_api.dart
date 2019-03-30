import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/logics/server_api.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/resources/strings.dart';

class OtherProfileAPI {

  void getOutOtherProfile() {
    sl.get<ServerAPI>().sameMatchFlagOff();
  }

  void connectToServer({@required String otherUserUID}) {
    sl.get<ServerAPI>().connectAlreadyFriendsStream(otherUserUID: otherUserUID);
    sl.get<ServerAPI>().connectAlreadyRequestStream(otherUserUID: otherUserUID);
  }

  Future<void> disconnectToServer() async{
    await sl.get<ServerAPI>().disconnectAlreadyFriendsStream();
    await sl.get<ServerAPI>().disconnectAlreadyRequestStream();
  }

  Future<void> sendRequest(String uid) async {
    DocumentReference doc = 
     sl.get<FirebaseAPI>().getFirestore().collection(firestoreUsersCollection)
      .document(uid).collection(firestoreFriendsSubCollection)
      .document(sl.get<CurrentUser>().uid);

    await sl.get<FirebaseAPI>().getFirestore().runTransaction((tx) async{
      await tx.set(doc, {
        firestoreFriendsField: false,
        firestoreFriendsAccepted: false,
        uidCol: sl.get<CurrentUser>().uid
      });
    });
  }

  Future<void> cancelRequest(String receiver) async {
    QuerySnapshot requestSnapshot = await sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreUsersCollection)
      .document(receiver)
      .collection(firestoreFriendsSubCollection)
      .where(firestoreFriendsField,isEqualTo: false)
      .where(firestoreFriendsUID,isEqualTo: sl.get<CurrentUser>().uid)
      .getDocuments();

    await sl.get<FirebaseAPI>().getFirestore().runTransaction((tx) async {
      await tx.delete(requestSnapshot.documents[0].reference);
    });
  }

}