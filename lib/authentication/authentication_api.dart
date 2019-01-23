import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AuthenticationAPI {

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static const String SUCCESS = 'SUCCESS';
  static const String FAILURE = 'FAILURE';

  // 회원가입
  Future<String> signUpWithFirebase(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password
    ).catchError((exception){
      if(exception is PlatformException){
        return FAILURE;
      }
    });
    return SUCCESS;
  }

  // 로그인
  Future<String> loginWithFirebase(String email, String password) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password
    ).catchError((exception){
      if(exception is PlatformException){
        return FAILURE;
      }
    });
    return SUCCESS;
  }
}

