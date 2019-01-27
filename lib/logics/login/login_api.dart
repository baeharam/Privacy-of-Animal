import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class LoginAPI {

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // 로그인
  Future<LOGIN_RESULT> login(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password
      );
    } catch(exception){
      return LOGIN_RESULT.FAILURE;
    }
    return LOGIN_RESULT.SUCCESS;
  }
}

enum LOGIN_RESULT {
  SUCCESS,
  FAILURE
}