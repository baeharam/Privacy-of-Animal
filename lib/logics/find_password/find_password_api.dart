import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class FindPasswordAPI {

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FIND_PASSWORD_RESULT> findPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch(exception){
      return FIND_PASSWORD_RESULT.FAILURE;
    }
    return FIND_PASSWORD_RESULT.SUCCESS;
  }
}

enum FIND_PASSWORD_RESULT {
  SUCCESS,
  FAILURE
}