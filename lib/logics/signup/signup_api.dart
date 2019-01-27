import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:privacy_of_animal/models/real_profile_table_model.dart';

class SignUpAPI {

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final Firestore _firestore = Firestore.instance;
  static String _uid;

  // 회원가입
  Future<SIGNUP_RESULT> registerAccount(String email, String password) async {
    try {
      FirebaseUser user = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password
      );
      _uid = user.uid;
    } catch(exception){
      return SIGNUP_RESULT.FAILURE;
    }
    return SIGNUP_RESULT.SUCCESS;
  }

  Future<SIGNUP_RESULT> registerProfile(RealProfileTableModel data) async {
    try {
      await _firestore.runTransaction((Transaction transaction) async{
        CollectionReference collectionReference = _firestore.collection('users');
        DocumentReference reference = collectionReference.document(_uid);
        await reference.setData({
          'name': data.name,
          'age': data.age,
          'job': data.job,
          'gender': data.gender
        });
      });
    } catch(exception){
      return SIGNUP_RESULT.FAILURE;
    }
    return SIGNUP_RESULT.SUCCESS;
  }

}

enum SIGNUP_RESULT {
  SUCCESS,
  FAILURE
}