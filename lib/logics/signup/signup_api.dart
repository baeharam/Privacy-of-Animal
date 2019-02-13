import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/database_helper.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/models/signup_model.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:sqflite/sqflite.dart';

class SignUpAPI {
  // 회원가입
  Future<SIGNUP_RESULT> registerAccount(SignUpModel data) async {
    try {
      await sl.get<FirebaseAPI>().auth.createUserWithEmailAndPassword(
        email: data.email,
        password: data.password
      ).then((user) => sl.get<CurrentUser>().uid = user.uid);

      await sl.get<FirebaseAPI>().firestore.runTransaction((tx) async{
        CollectionReference col = sl.get<FirebaseAPI>().firestore.collection(firestoreDeletedUserListCollection);
        DocumentReference doc = col.document(sl.get<CurrentUser>().uid);
        await doc.setData({
          'delete': true
        });
      }); 
    } catch(exception){
      return SIGNUP_RESULT.FAILURE;
    }
    return SIGNUP_RESULT.SUCCESS;
  }

  // 프로필 등록
  Future<PROFILE_RESULT> registerProfile(SignUpModel data) async {
    try {
      await registerProfileIntoFirestore(data);
      await registerProfileIntoLocalDB(data);
    } catch(exception){
      await sl.get<FirebaseAPI>().deleteUserAccount(sl.get<CurrentUser>().uid);
      return PROFILE_RESULT.FAILURE;
    }
    return PROFILE_RESULT.SUCCESS;
  }

  // Cloud Firestore에 저장
  Future<void> registerProfileIntoFirestore(SignUpModel data) async {
    await sl.get<FirebaseAPI>().firestore.runTransaction((transaction) async{
        CollectionReference collectionReference = sl.get<FirebaseAPI>().firestore.collection(firestoreUsersCollection);
        DocumentReference reference = collectionReference.document(sl.get<CurrentUser>().uid);
        await reference.setData({
          firestoreRealProfileField: {
            firestoreNameField: data.realProfileModel.name,
            firestoreAgeField: data.realProfileModel.age,
            firestoreJobField: data.realProfileModel.job,
            firestoreGenderField: data.realProfileModel.gender
          },
          firestoreFakeProfileField: {
            firestoreNickNameField: data.nickName
          },
          firestoreIsTagSelectedField: false,
          firestoreIsTagChattedField: false,
          firestoreIsFaceAnalyzedField: false
        });
      });
  }

  // 로컬에 저장
  Future<void> registerProfileIntoLocalDB(SignUpModel data) async {
    Database db = await sl.get<DatabaseHelper>().database;
    db.rawInsert(
      'INSERT INTO $realProfileTable($uidCol,$nameCol,$ageCol,$jobCol,$genderCol) '
      'VALUES("${sl.get<CurrentUser>().uid}",'
      '"${data.realProfileModel.name}","${data.realProfileModel.age}",'
      '"${data.realProfileModel.job}","${data.realProfileModel.gender}")');
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