import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/database_helper.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';

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