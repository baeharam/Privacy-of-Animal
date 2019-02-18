
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/models/same_match_model.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/resources/strings.dart';

class SameMatchAPI {


  // 전체 사용자 중에서 관심사가 가장 잘 맞는 애 선정해서 넘겨주기
  Future<SameMatchModel> findUser() async {
    SameMatchModel sameMatchModel =SameMatchModel();
    CurrentUser currentUser = sl.get<CurrentUser>();

    // 친구 목록 받아오기
    QuerySnapshot friendsSnapshot = await sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreUsersCollection).document(currentUser.uid)
      .collection(firestoreFriendsSubCollection).where(firestoreFriendsField,isEqualTo: true).getDocuments();
    List<String> friends = List<String>();
    for(DocumentSnapshot friendsDoc in friendsSnapshot.documents){
      friends.add(friendsDoc.documentID);
    }
    
    // 사용자 전체 목록 받아오기
    QuerySnapshot users = await sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreUsersCollection).getDocuments();

    List<List<DocumentSnapshot>> matchedPeople = List<List<DocumentSnapshot>>(6);
    Map<String,List<List<String>>> matchedTags = Map<String,List<List<String>>>();
    for(DocumentSnapshot user in users.documents) {
      // 친구관계라면 제외
      if(!(friends.contains(user.documentID))){
        // 친구 아니라면 매칭하는 태그 개수를 계산해서 해당하는 배열 인덱스에 넣는다.
        int matchNum = 0;
        if(currentUser.tagListModel.tagTitleList[0]
          ==user.data[firestoreTagField][firestoreTagTitle1Field]) {
            matchNum++;
            matchedTags[user.documentID].add(
              [currentUser.tagListModel.tagTitleList[0],
              user.data[firestoreTagField][firestoreTagDetail1Field]]
            );
          }
        if(currentUser.tagListModel.tagTitleList[1]
          ==user.data[firestoreTagField][firestoreTagTitle2Field]) {
            matchNum++;
            matchedTags[user.documentID].add(
              [currentUser.tagListModel.tagTitleList[1],
              user.data[firestoreTagField][firestoreTagDetail2Field]]
            );
          }
        if(currentUser.tagListModel.tagTitleList[2]
          ==user.data[firestoreTagField][firestoreTagTitle3Field]) {
            matchNum++;
            matchedTags[user.documentID].add(
              [currentUser.tagListModel.tagTitleList[2],
              user.data[firestoreTagField][firestoreTagDetail3Field]]
            );
          }
        if(currentUser.tagListModel.tagTitleList[3]
          ==user.data[firestoreTagField][firestoreTagTitle4Field]) {
            matchNum++;
            matchedTags[user.documentID].add(
              [currentUser.tagListModel.tagTitleList[3],
              user.data[firestoreTagField][firestoreTagDetail4Field]]
            );
          }
        if(currentUser.tagListModel.tagTitleList[4]
          ==user.data[firestoreTagField][firestoreTagTitle5Field]) {
            matchNum++;
            matchedTags[user.documentID].add(
              [currentUser.tagListModel.tagTitleList[4],
              user.data[firestoreTagField][firestoreTagDetail5Field]]
            );
          }
        matchedPeople[matchNum].add(user);
      }
    }

    // 가장 많이 매칭되는 태그부터 본다.
    for(int i=5; i>=0; i--){
      if(matchedPeople[i].isNotEmpty){
        int index = Random().nextInt(matchedPeople[i].length);
        List<List<String>> tags = matchedTags[matchedPeople[i][index].documentID];
        int randomIndex = Random().nextInt(tags.length);
        sameMatchModel.tagTitle = tags[randomIndex][0];
        sameMatchModel.tagDetail = tags[randomIndex][1];
        sameMatchModel.userInfo = matchedPeople[i][index];
        sameMatchModel.profileImage = sameMatchModel.userInfo.data[firestoreFakeProfileField][firestoreAnimalImageField];
        sameMatchModel.confidence =sameMatchModel.userInfo.data[firestoreFakeProfileField][firestoreAnimalConfidenceField];
        break;
      }
    }
    return sameMatchModel;
  }

}