import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:privacy_of_animal/models/signup_model.dart';
import 'package:privacy_of_animal/resources/strings.dart';

class SignUpAPI {

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final Firestore _firestore = Firestore.instance;
  static String _uid;

  // 회원가입
  Future<SIGNUP_RESULT> registerAccount(SignUpModel data) async {
    try {
      FirebaseUser user = await _auth.createUserWithEmailAndPassword(
        email: data.email,
        password: data.password
      );
      _uid = user.uid;
    } catch(exception){
      return SIGNUP_RESULT.FAILURE;
    }
    return SIGNUP_RESULT.SUCCESS;
  }

  // 프로필 등록
  Future<PROFILE_RESULT> registerProfile(SignUpModel data) async {
    try {
      await _firestore.runTransaction((Transaction transaction) async{
        CollectionReference collectionReference = _firestore.collection(firestoreUsersCollection);
        DocumentReference reference = collectionReference.document(_uid);
        await reference.setData({
          firestoreRealProfileField: {
            firestoreNameField: data.name,
            firestoreAgeField: data.age,
            firestoreJobField: data.job,
            firestoreGenderField: data.gender
          },
          firestoreIsTagSelectedField: false,
          firestoreIsFaceAnalyzedField: false
        });
      });
    } catch(exception){
      return PROFILE_RESULT.FAILURE;
    }
    return PROFILE_RESULT.SUCCESS;
  }

  // 실패한 부분에 포커싱
  void requestFocusOnRetry(BuildContext context, FocusNode focusNode){
    FocusScope.of(context).requestFocus(focusNode);
  }

}

enum SIGNUP_RESULT {
  SUCCESS,
  FAILURE
}

enum PROFILE_RESULT {
  SUCCESS,
  FAILURE
}