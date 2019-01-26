import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:privacy_of_animal/model/real_profile_table_model.dart';

class SignUpAPI {

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final Firestore _firestore = Firestore.instance;

  // 회원가입
  Future<SIGNUP_RESULT> registerAccount(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password
    ).catchError((exception){
      if(exception is PlatformException){
        return SIGNUP_RESULT.FAILURE;
      }
    });
    return SIGNUP_RESULT.SUCCESS;
  }

  Future<SIGNUP_RESULT> registerProfile(RealProfileTableModel data) async {
    await _firestore.runTransaction((Transaction transaction) async{
      CollectionReference collectionReference = _firestore.collection('users');
      DocumentReference reference = collectionReference.document(data.uid);
      await reference.setData({
        'name': data.name,
        'age': data.age,
        'job': data.job,
        'gender': data.gender
      });
    }).catchError((exception){
      if(exception is PlatformException){
        return SIGNUP_RESULT.FAILURE;
      }
    });
    return SIGNUP_RESULT.SUCCESS;
  }

}

enum SIGNUP_RESULT {
  SUCCESS,
  FAILURE
}