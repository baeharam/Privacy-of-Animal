import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/database_helper.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';

class LoginAPI {
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
    await _setSharedPreferences();
    if(sl.get<CurrentUser>().isTagSelected==false){
      return USER_CONDITION.NONE;
    } else if(sl.get<CurrentUser>().isTagChatted==false){
      return USER_CONDITION.TAG_SELECTED;
    } else if(sl.get<CurrentUser>().isFaceAnalyzed==false){
      return USER_CONDITION.TAG_CHATTED;
    } else {
      return USER_CONDITION.FACE_ANALYZED;
    }
  }

  Future<void> _setSharedPreferences() async {
    String uid = await sl.get<FirebaseAPI>().user;
    SharedPreferences prefs = await sl.get<DatabaseHelper>().sharedPreferences;

    sl.get<CurrentUser>().isTagSelected = prefs.getBool(uid+firestoreIsTagSelectedField);
    sl.get<CurrentUser>().isTagChatted = prefs.getBool(uid+firestoreIsTagChattedField);
    sl.get<CurrentUser>().isFaceAnalyzed = prefs.getBool(uid+firestoreIsFaceAnalyzedField);
    if(sl.get<CurrentUser>().isTagSelected==null || sl.get<CurrentUser>().isTagChatted==null || sl.get<CurrentUser>().isFaceAnalyzed==null){
      sl.get<CurrentUser>().isTagSelected = await fetchUserCondition(uid, firestoreIsTagSelectedField);
      sl.get<CurrentUser>().isTagChatted = await fetchUserCondition(uid, firestoreIsTagChattedField);
      sl.get<CurrentUser>().isFaceAnalyzed = await fetchUserCondition(uid, firestoreIsFaceAnalyzedField);
      prefs.setBool(uid+firestoreIsTagSelectedField, sl.get<CurrentUser>().isTagSelected);
      prefs.setBool(uid+firestoreIsTagChattedField, sl.get<CurrentUser>().isTagChatted);
      prefs.setBool(uid+firestoreIsFaceAnalyzedField, sl.get<CurrentUser>().isFaceAnalyzed);
    }
  }

  // Firestore에서 사용자 상태 가져오기
  Future<bool> fetchUserCondition(String uid, String field) async {
    DocumentSnapshot document = await sl.get<FirebaseAPI>().firestore.collection(firestoreUsersCollection).document(uid).get();
    return document[field];
  }
}

enum LOGIN_RESULT {
  SUCCESS,
  FAILURE
}

enum USER_CONDITION {
  NONE,
  TAG_SELECTED,
  TAG_CHATTED,
  FACE_ANALYZED
}