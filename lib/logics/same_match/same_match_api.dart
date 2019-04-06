
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/logics/server/server.dart';
import 'package:privacy_of_animal/models/same_match_model.dart';
import 'package:privacy_of_animal/models/user_model.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/resources/strings.dart';

class SameMatchAPI {

  bool _isInSameMatchScreen = false;

  void enterOtherProfileScreen() => _isInSameMatchScreen = true;
  void getOutOtherProfileScreen() => _isInSameMatchScreen = false;

  void connectToServer(String otherUserUID) {
    if(!_isInSameMatchScreen) {
      sl.get<ServerRequestAPI>().connectRequestToStream(otherUserUID: otherUserUID);
    }
  }

  Future<void> disconnectToServer() async{
    if(!_isInSameMatchScreen) {
      await sl.get<ServerRequestAPI>().disconnectRequestToStream();
    }
  }

  Future<void> sendRequest(String uid) async {
    DocumentReference doc = 
     sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreUsersCollection)
      .document(uid)
      .collection(firestoreFriendsSubCollection)
      .document(sl.get<CurrentUser>().uid);

    await sl.get<FirebaseAPI>().getFirestore().runTransaction((tx) async{
      await tx.set(doc, {
        firestoreFriendsField: false,
        firestoreFriendsAccepted: false,
        uidCol: sl.get<CurrentUser>().uid
      });
    });
    sl.get<CurrentUser>().isRequestTo = true;
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
    sl.get<CurrentUser>().isRequestTo = false;
  }

  // 전체 사용자 중에서 관심사가 가장 잘 맞는 애 선정해서 넘겨주기
  Future<SameMatchModel> findUser() async {
    SameMatchModel sameMatchModel =SameMatchModel();
    CurrentUser currentUser = sl.get<CurrentUser>();

    // 친구 목록 받아오기
    QuerySnapshot friendsSnapshot = await sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreUsersCollection)
      .document(currentUser.uid)
      .collection(firestoreFriendsSubCollection)
      .where(firestoreFriendsField,isEqualTo: true)
      .getDocuments();
    List<String> friends = List<String>();
    for(DocumentSnapshot friendsDoc in friendsSnapshot.documents){
      friends.add(friendsDoc.documentID);
    }
    
    // 사용자 전체 목록 받아오기
    QuerySnapshot users = await sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreUsersCollection)
      .where(firestoreIsFaceAnalyzedField, isEqualTo: true)
      .where(firestoreIsTagChattedField, isEqualTo: true)
      .where(firestoreIsTagSelectedField, isEqualTo: true)
      .getDocuments();

    List<List<DocumentSnapshot>> matchedPeople = List<List<DocumentSnapshot>>(6);
    Map<String,List<List<String>>> matchedTags = Map<String,List<List<String>>>();
    for(DocumentSnapshot user in users.documents) {
      QuerySnapshot friendsRequestSnapshot = await sl.get<FirebaseAPI>().getFirestore()
        .collection(firestoreUsersCollection)
        .document(user.documentID)
        .collection(firestoreFriendsSubCollection)
        .where(uidCol, isEqualTo: currentUser.uid)
        .where(firestoreFriendsField, isEqualTo: false)
        .getDocuments();

      /// [제외하는 경우]
      /// [1. 친구]
      /// [2. 자기자신]
      /// [3. 내가 친구신청을 이미 한 사람]
      /// [4. 친구신청을 받은 경우의 사람]
      
      bool isRequestingUser = false;
      for(UserModel userModel in sl.get<CurrentUser>().requestFromList) {
        if(userModel.uid.compareTo(user.documentID)==0){
          isRequestingUser = true;
          break;
        }
      }

      if(!(friends.contains(user.documentID)) 
        && user.documentID!=currentUser.uid 
        && friendsRequestSnapshot.documents.length==0
        && !isRequestingUser){
        int matchNum = 0;       
        matchedTags[user.documentID] = List<List<String>>();

        List<String> tagTitles = [
          user.data[firestoreTagField][firestoreTagTitle1Field],
          user.data[firestoreTagField][firestoreTagTitle2Field],
          user.data[firestoreTagField][firestoreTagTitle3Field],
          user.data[firestoreTagField][firestoreTagTitle4Field],
          user.data[firestoreTagField][firestoreTagTitle5Field]
        ];

        List<String> tagDetails = [
          user.data[firestoreTagField][firestoreTagDetail1Field],
          user.data[firestoreTagField][firestoreTagDetail2Field],
          user.data[firestoreTagField][firestoreTagDetail3Field],
          user.data[firestoreTagField][firestoreTagDetail4Field],
          user.data[firestoreTagField][firestoreTagDetail5Field]
        ];

        int matchedIndex = 0;

        matchedIndex = tagTitles.lastIndexOf(currentUser.tagListModel.tagTitleList[0]);
        if(matchedIndex!=-1) {
          matchNum++;
          matchedTags[user.documentID].add(
            [currentUser.tagListModel.tagTitleList[0],
            tagDetails[matchedIndex]]
          );
        }
        matchedIndex = tagTitles.lastIndexOf(currentUser.tagListModel.tagTitleList[1]);
        if(matchedIndex!=-1) {
          matchNum++;
          matchedTags[user.documentID].add(
            [currentUser.tagListModel.tagTitleList[1],
            tagDetails[matchedIndex]]
          );
        }
        matchedIndex = tagTitles.lastIndexOf(currentUser.tagListModel.tagTitleList[2]);
        if(matchedIndex!=-1) {
          matchNum++;
          matchedTags[user.documentID].add(
            [currentUser.tagListModel.tagTitleList[2],
            tagDetails[matchedIndex]]
          );
        }
        matchedIndex = tagTitles.lastIndexOf(currentUser.tagListModel.tagTitleList[3]);
        if(matchedIndex!=-1) {
          matchNum++;
          matchedTags[user.documentID].add(
            [currentUser.tagListModel.tagTitleList[3],
            tagDetails[matchedIndex]]
          );
        }
        matchedIndex = tagTitles.lastIndexOf(currentUser.tagListModel.tagTitleList[4]);
        if(matchedIndex!=-1) {
          matchNum++;
          matchedTags[user.documentID].add(
            [currentUser.tagListModel.tagTitleList[4],
            tagDetails[matchedIndex]]
          );
        }
        if(matchedPeople[matchNum]==null) matchedPeople[matchNum] = List<DocumentSnapshot>();
        matchedPeople[matchNum].add(user);
      }
    }

    // 가장 많이 매칭되는 태그부터 본다.
    for(int i=5; i>=1; i--){
      if(matchedPeople[i]==null) continue;
      if(matchedPeople[i].isNotEmpty){
        int index = Random().nextInt(matchedPeople[i].length);
        List<List<String>> tags = matchedTags[matchedPeople[i][index].documentID];
        int randomIndex = Random().nextInt(tags.length);
        sameMatchModel.tagTitle = tags[randomIndex][0];
        sameMatchModel.tagDetail = tags[randomIndex][1];

        UserModel userInfo = UserModel.fromSnapshot(snapshot: matchedPeople[i][index]);

        sameMatchModel.userInfo = userInfo;
        sameMatchModel.profileImage = userInfo.fakeProfileModel.animalImage;
        sameMatchModel.confidence = userInfo.fakeProfileModel.animalConfidence;
        sameMatchModel.nickName = userInfo.fakeProfileModel.nickName;
        sameMatchModel.age = userInfo.fakeProfileModel.age;
        sameMatchModel.gender = userInfo.fakeProfileModel.gender;
        sameMatchModel.emotion = userInfo.fakeProfileModel.emotion;
        sameMatchModel.animalName =  userInfo.fakeProfileModel.animalName;
        break;
      }
    }
    return sameMatchModel;
  }

}