
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/database_helper.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class HomeAPI {
  // 바로 홈 화면으로 갈 경우 그에 해당하는 데이터를 가져옴
  Future<FETCH_RESULT> fetchUserData() async {
    try {
      await _checkDBAndCallFirestore();
      String uid = sl.get<CurrentUser>().uid;
      Database db = await sl.get<DatabaseHelper>().database;

      // 태그 정보 가져오기
      List<Map<String,dynamic>> tags = 
      await db.rawQuery('SELECT * FROM $tagTable WHERE $uidCol="$uid"');
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

      // 실제 프로필 정보 가져오기
      List<Map<String,dynamic>> realProfile = 
      await db.rawQuery('SELECT * FROM $realProfileTable WHERE $uidCol="$uid"');
      sl.get<CurrentUser>().realProfileModel.name = realProfile[0][nameCol];
      sl.get<CurrentUser>().realProfileModel.age = realProfile[0][ageCol];
      sl.get<CurrentUser>().realProfileModel.gender = realProfile[0][genderCol];
      sl.get<CurrentUser>().realProfileModel.job = realProfile[0][jobCol];

      // 가상 프로필 정보 가져오기
      List<Map<String,dynamic>> fakeProfile = 
      await db.rawQuery('SELECT * FROM $fakeProfileTable WHERE $uidCol="$uid"');
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

      // 알림 설정 가져오기
      SharedPreferences prefs = await sl.get<DatabaseHelper>().sharedPreferences;
      if(prefs.getBool(friendsRequestNotification)==null){
        prefs.setBool(friendsRequestNotification, false);
        sl.get<CurrentUser>().friendsRequestNotification = false;
      } else {
        sl.get<CurrentUser>().friendsRequestNotification = prefs.getBool(friendsRequestNotification);
        sl.get<CurrentUser>().friendsRequestStream = sl.get<FirebaseAPI>().getFirestore()
          .collection(firestoreUsersCollection).document(sl.get<CurrentUser>().uid)
          .collection(firestoreFriendsSubCollection).where(firestoreFriendsField, isEqualTo: false)
          .snapshots();
      }
      if(prefs.getBool(messageNotification)==null){
        prefs.setBool(messageNotification, true);
        sl.get<CurrentUser>().messageNotification = false;
      } else {
        sl.get<CurrentUser>().messageNotification = prefs.getBool(messageNotification);
        sl.get<CurrentUser>().messagesStream = sl.get<FirebaseAPI>().getFirestore()
          .collection(firestoreFriendsMessageCollection)
          .where(firestoreChatUsersField, arrayContains: sl.get<CurrentUser>().uid)
          .snapshots();
      }

      // 데이터 가져왔다고 설정
      sl.get<CurrentUser>().isDataFetched = true;
    } catch(exception) {
      return FETCH_RESULT.FAILURE;
    }
    return FETCH_RESULT.SUCCESS;
  }

  // 로컬 DB체크한 후에 없으면 서버에서 가져옴
  Future<void> _checkDBAndCallFirestore() async {
    Database db = await sl.get<DatabaseHelper>().database;
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
    DocumentSnapshot doc = await col.document(sl.get<CurrentUser>().uid).get();
    Database db = await sl.get<DatabaseHelper>().database;
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
    DocumentSnapshot doc = await col.document(sl.get<CurrentUser>().uid).get();
    Database db = await sl.get<DatabaseHelper>().database;
    await db.rawInsert(
      'INSERT INTO $realProfileTable ($uidCol,$nameCol,$ageCol,$genderCol,$jobCol) VALUES('
      '"${sl.get<CurrentUser>().uid}",'
      '"${doc.data[firestoreRealProfileField][firestoreNameField]}","${doc.data[firestoreRealProfileField][firestoreAgeField]}",'
      '"${doc.data[firestoreRealProfileField][firestoreGenderField]}","${doc.data[firestoreRealProfileField][firestoreJobField]}")'
    );
  }

  Future<void> _fetchTagsFromFirestore() async {
    CollectionReference col = sl.get<FirebaseAPI>().getFirestore().collection(firestoreUsersCollection);
    DocumentSnapshot doc = await col.document(sl.get<CurrentUser>().uid).get();
    Database db = await sl.get<DatabaseHelper>().database;
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

enum FETCH_RESULT {
  SUCCESS,
  FAILURE
}