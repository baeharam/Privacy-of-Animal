

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/resources/strings.dart';

class SettingAPI {

  Future<void> logout() async {
    await sl.get<FirebaseAPI>().getAuth().signOut();
  }

  Future<void> deleteAllInfoOfUser() async {

    CurrentUser currentUser = sl.get<CurrentUser>();

    // 계정 삭제
    await sl.get<FirebaseAPI>().deleteUserAccount(currentUser.uid);

    WriteBatch batch = sl.get<FirebaseAPI>().getFirestore().batch();
  
    // 친구 삭제
    QuerySnapshot friendsSnapshot = await sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreUsersCollection).document(currentUser.uid)
      .collection(firestoreFriendsSubCollection).where(firestoreFriendsField,isEqualTo: true)
      .getDocuments();

    for(DocumentSnapshot friends in friendsSnapshot.documents) {
      QuerySnapshot otherSnapshot = await sl.get<FirebaseAPI>().getFirestore()
        .collection(firestoreUsersCollection).document(friends.documentID)
        .collection(firestoreFriendsSubCollection).where(uidCol, isEqualTo: currentUser.uid)
        .getDocuments();
      batch.delete(friends.reference);
      batch.delete(otherSnapshot.documents[0].reference);
    }

    // 친구 신청 삭제
    QuerySnapshot friendsRequestSnapshot = await sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreUsersCollection).document(currentUser.uid)
      .collection(firestoreFriendsSubCollection).where(firestoreFriendsField,isEqualTo: false)
      .getDocuments();

    for(DocumentSnapshot friendsRequest in friendsRequestSnapshot.documents) {
      batch.delete(friendsRequest.reference);
    }

    QuerySnapshot allUsersSnapshot = await sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreUsersCollection).getDocuments();
    
    for(DocumentSnapshot user in allUsersSnapshot.documents){
      QuerySnapshot otherFriendsRequestSnapshot
        = await user.reference.collection(firestoreFriendsSubCollection)
          .where(uidCol, isEqualTo: currentUser.uid).getDocuments();
      batch.delete(otherFriendsRequestSnapshot.documents[0].reference);
    }

    // 대화 삭제
    QuerySnapshot messagesSnapshot = await sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreFriendsMessageCollection)
      .where(firestoreChatUsersField, arrayContains: currentUser.uid)
      .getDocuments();

    for(DocumentSnapshot message in messagesSnapshot.documents) {
      batch.delete(message.reference);
    }
  
    await batch.commit();
  }

}