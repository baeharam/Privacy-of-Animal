import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class SignUpAPI {

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // 회원가입
  Future<AUTH_RESULT> signUpWithFirebase(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password
    ).catchError((exception){
      if(exception is PlatformException){
        return AUTH_RESULT.FAILURE;
      }
    });
    return AUTH_RESULT.SUCCESS;
  }
}

enum AUTH_RESULT {
  SUCCESS,
  FAILURE
}