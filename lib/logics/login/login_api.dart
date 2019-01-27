import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class LoginAPI {

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // 로그인
  Future<LOGIN_RESULT> loginWithFirebase(String email, String password) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password
    ).catchError((exception){
      if(exception is PlatformException){
        return LOGIN_RESULT.FAILURE;
      }
    });
    return LOGIN_RESULT.SUCCESS;
  }
}

enum LOGIN_RESULT {
  SUCCESS,
  FAILURE
}