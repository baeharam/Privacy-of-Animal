import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationAPI {

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // 회원가입
  Future<FirebaseUser> signUpWithFirebase(String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password
    );
  }

  // 로그인
  Future<FirebaseUser> loginWithFirebase(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password
    );
  }
}