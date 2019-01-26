import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:privacy_of_animal/model/real_profile_table_model.dart';

class SignUpAPI {

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // 회원가입
  Future<SIGNUP_RESULT> signUpWithFirebase(String email, String password, RealProfileTableModel data) async {
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
}

enum SIGNUP_RESULT {
  SUCCESS,
  FAILURE
}