import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/resources/strings.dart';

class FriendsAPI {

  // 친구정보 가져오기
  Future<List<DocumentSnapshot>> fetchFriendsList(List<dynamic> friends) async {
    List<DocumentSnapshot> friendsList = List<DocumentSnapshot>();
    if(friends.length==0) return friendsList;
    for(var user in friends) {
      DocumentSnapshot userInfo = await sl.get<FirebaseAPI>().getFirestore()
        .collection(firestoreUsersCollection)
        .document(user as String).get();
      friendsList.add(userInfo);
    }
    return friendsList;
  }

  // 친구신청 수락하기
  // 친구 신청 목록에서 삭제 + 현재유저 친구목록에 넣기 + 신청유저 친구목록에 넣기 = 일괄작업 batch로
  Future<void> acceptFriendsRequest(String requestingUser) async {
    DocumentReference myselfDoc = sl.get<FirebaseAPI>().getFirestore().collection(firestoreUsersCollection)
      .document(sl.get<CurrentUser>().uid);
    DocumentReference requestingUserDoc = sl.get<FirebaseAPI>().getFirestore().collection(firestoreUsersCollection)
      .document(requestingUser);
    
    WriteBatch batch = sl.get<FirebaseAPI>().getFirestore().batch();

    batch.updateData(myselfDoc, {firestoreFriendsRequestField: FieldValue.arrayRemove([requestingUser])});
    batch.updateData(myselfDoc, {firestoreFriendsField: FieldValue.arrayUnion([requestingUser])});
    batch.updateData(requestingUserDoc, {firestoreFriendsField: FieldValue.arrayUnion([sl.get<CurrentUser>().uid])});

    await batch.commit();
  }
}