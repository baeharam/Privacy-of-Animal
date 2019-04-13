import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/database_helper.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/logics/server/server.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class HomeAPI {
  static bool isProfileDataFetched = false;
  static bool isFriendsDataFetched = false;
  static bool isChatRoomListDataFetched = false;

  Database db;
  SharedPreferences prefs;
  String uid;

  void deactivateFlags() {
    debugPrint('Call resetForLogout()');

    isProfileDataFetched = false;
    isFriendsDataFetched = false;
    isChatRoomListDataFetched = false;
  }

  Future<void> _apiInitialization() async {
    debugPrint('HomeAPI 초기화');

    db = await sl.get<DatabaseHelper>().database;
    prefs = await sl.get<DatabaseHelper>().sharedPreferences;
    uid = sl.get<CurrentUser>().uid;
  }

  Future<void> fetchProfileData() async {
    if(!isProfileDataFetched) {
      debugPrint('프로필 데이터 가져오기');

      await _apiInitialization();
      await _checkDBAndCallFirestore();

      var tags = await db.rawQuery('SELECT * FROM $tagTable WHERE $uidCol="$uid"');
      _setTagData(tags);

      var realProfile = await db.rawQuery('SELECT * FROM $realProfileTable WHERE $uidCol="$uid"');
      _setRealProfile(realProfile);

      var fakeProfile = await db.rawQuery('SELECT * FROM $fakeProfileTable WHERE $uidCol="$uid"');
      _setFakeProfile(fakeProfile);

      isProfileDataFetched = true;
    }
  }

  Future<void> fetchFriendsData() async {
    if(!isFriendsDataFetched) {
      debugPrint('친구, 친구신청 데이터 가져오기');

      await _setFriendsNotification(uid);
      await sl.get<ServerFriendsAPI>().connectFriendsList();
      await sl.get<ServerRequestAPI>().connectRequestFromList();

      isFriendsDataFetched = true;
    }
  }

  Future<void> fetchChatRoomListData() async {
    if(!isChatRoomListDataFetched) {
      debugPrint('채팅 리스트 데이터 가져오기');

      await _setChatRoomNotification();
      await sl.get<ServerChatAPI>().connectAllChatRoom();

      isChatRoomListDataFetched = true;
    }
  }

  void _setTagData(List<Map<String,dynamic>> tags) {
    sl.get<CurrentUser>().tagListModel.tagTitleList.add(tags[0][tagName1Col]);
    sl.get<CurrentUser>().tagListModel.tagTitleList.add(tags[0][tagName2Col]);
    sl.get<CurrentUser>().tagListModel.tagTitleList.add(tags[0][tagName3Col]);
    sl.get<CurrentUser>().tagListModel.tagTitleList.add(tags[0][tagName4Col]);
    sl.get<CurrentUser>().tagListModel.tagTitleList.add(tags[0][tagName5Col]);
    sl.get<CurrentUser>().tagListModel.tagDetailList.add(tags[0][tagDetail1Col]);
    sl.get<CurrentUser>().tagListModel.tagDetailList.add(tags[0][tagDetail2Col]);
    sl.get<CurrentUser>().tagListModel.tagDetailList.add(tags[0][tagDetail3Col]);
    sl.get<CurrentUser>().tagListModel.tagDetailList.add(tags[0][tagDetail4Col]);
    sl.get<CurrentUser>().tagListModel.tagDetailList.add(tags[0][tagDetail5Col]);
  }

  void _setRealProfile(List<Map<String,dynamic>> realProfile) {
    sl.get<CurrentUser>().realProfileModel.name = realProfile[0][nameCol];
    sl.get<CurrentUser>().realProfileModel.age = realProfile[0][ageCol];
    sl.get<CurrentUser>().realProfileModel.gender = realProfile[0][genderCol];
    sl.get<CurrentUser>().realProfileModel.job = realProfile[0][jobCol];
  }

  void _setFakeProfile(List<Map<String,dynamic>> fakeProfile) {
    sl.get<CurrentUser>().fakeProfileModel.nickName = fakeProfile[0][nickNameCol];
    sl.get<CurrentUser>().fakeProfileModel.age = fakeProfile[0][fakeAgeCol];
    sl.get<CurrentUser>().fakeProfileModel.gender = fakeProfile[0][fakeGenderCol];
    sl.get<CurrentUser>().fakeProfileModel.emotion = fakeProfile[0][fakeEmotionCol];
    sl.get<CurrentUser>().fakeProfileModel.ageConfidence = fakeProfile[0][fakeAgeConfidenceCol];
    sl.get<CurrentUser>().fakeProfileModel.genderConfidence = fakeProfile[0][fakeGenderConfidenceCol];
    sl.get<CurrentUser>().fakeProfileModel.emotionConfidence = fakeProfile[0][fakeEmotionConfidenceCol];
    sl.get<CurrentUser>().fakeProfileModel.animalName = fakeProfile[0][animalNameCol];
    sl.get<CurrentUser>().fakeProfileModel.animalImage = fakeProfile[0][animalImageCol];
    sl.get<CurrentUser>().fakeProfileModel.animalConfidence = fakeProfile[0][animalConfidenceCol];
    sl.get<CurrentUser>().fakeProfileModel.celebrity = fakeProfile[0][celebrityCol];
    sl.get<CurrentUser>().fakeProfileModel.celebrityConfidence = fakeProfile[0][celebrityConfidenceCol];
    sl.get<CurrentUser>().fakeProfileModel.analyzedTime = fakeProfile[0][analyzedTimeCol];
  }

  Future<void> _setFriendsNotification(String uid) async{
    if(prefs.getBool(uid+friendsNotification)==null){
      prefs.setBool(uid+friendsNotification, false);
      sl.get<CurrentUser>().friendsNotification = false;
    } else {
      sl.get<CurrentUser>().friendsNotification = prefs.getBool(uid+friendsNotification);
    }
  }

  Future<void> _setChatRoomNotification() async{
    QuerySnapshot chatRoomsSnapshot = await sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreFriendsMessageCollection)
      .where('$firestoreChatUsersField.${sl.get<CurrentUser>().uid}',isEqualTo: true)
      .getDocuments();
    
    for(DocumentSnapshot chatRoomSnapshot in chatRoomsSnapshot.documents) {
      String friendsUID = '';
      (chatRoomSnapshot.data[firestoreChatUsersField] as Map).forEach((key,value){
        if(key != sl.get<CurrentUser>().uid){
          friendsUID = key;
        }
      });
      if(prefs.getBool(friendsUID)==null) {
        prefs.setBool(friendsUID, false);
        sl.get<CurrentUser>().chatRoomNotification[friendsUID] = false;
      } else {
        sl.get<CurrentUser>().chatRoomNotification[friendsUID] = prefs.getBool(friendsUID);
      }
    }
  }

  // 로컬 DB체크한 후에 없으면 서버에서 가져옴
  Future<void> _checkDBAndCallFirestore() async {
    List tags = await db.rawQuery('SELECT * FROM $tagTable WHERE $uidCol="${sl.get<CurrentUser>().uid}"');
    if(tags.length==0){
      await _fetchTagsFromFirestore();
    }

    List realProfile = await db.rawQuery('SELECT * FROM $realProfileTable WHERE $uidCol="${sl.get<CurrentUser>().uid}"');
    if(realProfile.length==0){
      await _fetchRealProfileFromFirestore();
    }

    List fakeProfile = await db.rawQuery('SELECT * FROM $fakeProfileTable WHERE $uidCol="${sl.get<CurrentUser>().uid}"');
    if(fakeProfile.length==0){
      await _fetchFakeProfileFromFirestore();
    }
  }

  Future<void> _fetchFakeProfileFromFirestore() async {
    CollectionReference col = sl.get<FirebaseAPI>().getFirestore().collection(firestoreUsersCollection);
    DocumentSnapshot doc = await col.document(uid).get();
    await db.rawInsert(
      'INSERT INTO $fakeProfileTable ($uidCol,$nickNameCol,$fakeAgeCol,$fakeGenderCol,$fakeEmotionCol,'
      '$fakeAgeConfidenceCol,$fakeGenderConfidenceCol,$fakeEmotionConfidenceCol,'
      '$animalNameCol,$animalImageCol,$animalConfidenceCol,$celebrityCol,$celebrityConfidenceCol,$analyzedTimeCol) VALUES('
      '"${sl.get<CurrentUser>().uid}",'
      '"${doc.data[firestoreFakeProfileField][firestoreNickNameField]}","${doc.data[firestoreFakeProfileField][firestoreFakeAgeField]}",'
      '"${doc.data[firestoreFakeProfileField][firestoreFakeGenderField]}","${doc.data[firestoreFakeProfileField][firestoreFakeEmotionField]}",'
      '"${doc.data[firestoreFakeProfileField][firestoreFakeAgeConfidenceField]}","${doc.data[firestoreFakeProfileField][firestoreFakeGenderConfidenceField]}",'
      '"${doc.data[firestoreFakeProfileField][firestoreFakeEmotionConfidenceField]}","${doc.data[firestoreFakeProfileField][firestoreAnimalNameField]}",'
      '"${doc.data[firestoreFakeProfileField][firestoreAnimalImageField]}","${doc.data[firestoreFakeProfileField][firestoreAnimalConfidenceField]}",'
      '"${doc.data[firestoreFakeProfileField][firestoreCelebrityField]}","${doc.data[firestoreFakeProfileField][firestoreCelebrityConfidenceField]}",'
      '"${doc.data[firestoreFakeProfileField][firestoreAnalyzedTimeField]}")'
    );
  }

  Future<void> _fetchRealProfileFromFirestore() async {
    CollectionReference col = sl.get<FirebaseAPI>().getFirestore().collection(firestoreUsersCollection);
    DocumentSnapshot doc = await col.document(uid).get();
    await db.rawInsert(
      'INSERT INTO $realProfileTable ($uidCol,$nameCol,$ageCol,$genderCol,$jobCol) VALUES('
      '"${sl.get<CurrentUser>().uid}",'
      '"${doc.data[firestoreRealProfileField][firestoreNameField]}","${doc.data[firestoreRealProfileField][firestoreAgeField]}",'
      '"${doc.data[firestoreRealProfileField][firestoreGenderField]}","${doc.data[firestoreRealProfileField][firestoreJobField]}")'
    );
  }

  Future<void> _fetchTagsFromFirestore() async {
    CollectionReference col = sl.get<FirebaseAPI>().getFirestore().collection(firestoreUsersCollection);
    DocumentSnapshot doc = await col.document(uid).get();
    await db.rawInsert(
      'INSERT INTO $tagTable ($uidCol,$tagName1Col,$tagName2Col,$tagName3Col,$tagName4Col,$tagName5Col,'
      '$tagDetail1Col,$tagDetail2Col,$tagDetail3Col,$tagDetail4Col,$tagDetail5Col) VALUES('
      '"${sl.get<CurrentUser>().uid}",'
      '"${doc.data[firestoreTagField][firestoreTagTitle1Field]}","${doc.data[firestoreTagField][firestoreTagTitle2Field]}",'
      '"${doc.data[firestoreTagField][firestoreTagTitle3Field]}","${doc.data[firestoreTagField][firestoreTagTitle4Field]}",'
      '"${doc.data[firestoreTagField][firestoreTagTitle5Field]}","${doc.data[firestoreTagField][firestoreTagDetail1Field]}",'
      '"${doc.data[firestoreTagField][firestoreTagDetail2Field]}","${doc.data[firestoreTagField][firestoreTagDetail3Field]}",'
      '"${doc.data[firestoreTagField][firestoreTagDetail4Field]}","${doc.data[firestoreTagField][firestoreTagDetail5Field]}")'
    );
  }
}

enum TAB {
  MATCH,
  CHAT,
  FRIENDS,
  PROFILE
}