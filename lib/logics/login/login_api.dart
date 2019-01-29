import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginAPI {

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final Firestore _firestore = Firestore.instance;

  // 로그인
  Future<LOGIN_RESULT> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password
      );
    } catch(exception){
      return LOGIN_RESULT.FAILURE;
    }
    return LOGIN_RESULT.SUCCESS;
  }

  // 비밀번호 찾기
  Future<LOGIN_RESULT> findPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch(exception){
      return LOGIN_RESULT.FAILURE;
    }
    return LOGIN_RESULT.SUCCESS;
  }

  // 사용자 상태 확인
  Future<USER_CONDITION> checkUserCondition() async {
    String uid = await _auth.currentUser().then((user) => user.uid).catchError((error)=> null);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isTagSelected = prefs.getBool(uid+firestoreIsTagSelectedField);
    bool isFaceAnalyzed = prefs.getBool(uid+firestoreIsFaceAnalyzedField);
    if(isTagSelected==null || isFaceAnalyzed==null){
      isTagSelected = await fetchUserCondition(uid, firestoreIsTagSelectedField);
      isFaceAnalyzed = await fetchUserCondition(uid, firestoreIsFaceAnalyzedField);
      prefs.setBool(uid+firestoreIsTagSelectedField, isTagSelected);
      prefs.setBool(uid+firestoreIsFaceAnalyzedField, isFaceAnalyzed);
    }
    if(isTagSelected==false){
      return USER_CONDITION.NONE;
    } else if(isFaceAnalyzed==false){
      return USER_CONDITION.TAG_SELECTED;
    } else {
      return USER_CONDITION.FACE_ANALYZED;
    }
  }

  // Firestore에서 사용자 상태 가져오기
  Future<bool> fetchUserCondition(String uid, String field) async {
    DocumentSnapshot document = await _firestore.collection(firestoreUsersCollection).document(uid).get();
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
  FACE_ANALYZED
}