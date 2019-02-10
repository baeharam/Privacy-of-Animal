import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/database_helper.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:sqflite/sqflite.dart';

class LoginAPI {

  SharedPreferences prefs;
  String uid;

  // 로그인
  Future<LOGIN_RESULT> login(String email, String password) async {
    try {
      await sl.get<FirebaseAPI>().auth.signInWithEmailAndPassword(
        email: email,
        password: password
      );
    } catch(exception){
      return LOGIN_RESULT.FAILURE;
    }
    sl.get<CurrentUser>().uid = await sl.get<FirebaseAPI>().user;
    return LOGIN_RESULT.SUCCESS;
  }

  // 비밀번호 찾기
  Future<LOGIN_RESULT> findPassword(String email) async {
    try {
      await sl.get<FirebaseAPI>().auth.sendPasswordResetEmail(email: email);
    } catch(exception){
      return LOGIN_RESULT.FAILURE;
    }
    return LOGIN_RESULT.SUCCESS;
  }

  // 사용자 상태 확인
  Future<USER_CONDITION> checkUserCondition() async {
    await _setLoginFlags();
    if(prefs.getBool(uid+isTagSelected)==false){
      return USER_CONDITION.NONE;
    } else if(prefs.getBool(uid+isTagChatted)==false){
      return USER_CONDITION.TAG_SELECTED;
    } else if(prefs.getBool(uid+isFaceAnalyzed)==false){
      return USER_CONDITION.TAG_CHATTED;
    } else {
      return USER_CONDITION.FACE_ANALYZED;
    }
  }

  // 상태에 따라 보여지는 화면이 다르기 때문에 SharedPreferences 값 설정해주어야 함
  Future<void> _setLoginFlags() async {
    uid = await sl.get<FirebaseAPI>().user;
    prefs = await sl.get<DatabaseHelper>().sharedPreferences;

    bool tagSelectFlag = prefs.getBool(uid+isTagSelected);
    bool tagChatFlag = prefs.getBool(uid+isTagChatted);
    bool faceAnalyzeFlag = prefs.getBool(uid+isFaceAnalyzed);
    if(tagSelectFlag==null || tagChatFlag==null || faceAnalyzeFlag==null){
      DocumentSnapshot document = await sl.get<FirebaseAPI>().firestore.collection(firestoreUsersCollection).document(uid).get();
      prefs.setBool(uid+isTagSelected, document[firestoreIsTagSelectedField]);
      prefs.setBool(uid+firestoreIsTagChattedField, document[firestoreIsTagChattedField]);
      prefs.setBool(uid+firestoreIsFaceAnalyzedField, document[firestoreIsFaceAnalyzedField]);
    }
  }

  // 바로 홈 화면으로 갈 경우 그에 해당하는 데이터를 가져옴
  Future<FETCH_RESULT> fetchUserData() async {
    if(sl.get<CurrentUser>().isDataFetched) return FETCH_RESULT.SUCCESS;
    try {
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

      sl.get<CurrentUser>().isDataFetched = true;
    
    } catch(exception){
      return FETCH_RESULT.FAILURE;
    }
    return FETCH_RESULT.SUCCESS;
  }
}

enum LOGIN_RESULT {
  SUCCESS,
  FAILURE
}

enum FETCH_RESULT {
  SUCCESS,
  FAILURE
}

enum USER_CONDITION {
  NONE,
  TAG_SELECTED,
  TAG_CHATTED,
  FACE_ANALYZED
}