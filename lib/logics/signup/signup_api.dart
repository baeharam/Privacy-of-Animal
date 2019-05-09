import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/database_api.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/models/signup_model.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:sqflite/sqflite.dart';

class SignUpAPI {
  // 회원가입
  Future<void> registerAccount(SignUpModel data) async {
    await sl.get<FirebaseAPI>().getAuth().createUserWithEmailAndPassword(
      email: data.email,
      password: data.password
    ).then((user) => sl.get<CurrentUser>().uid = user.uid);

    await sl.get<FirebaseAPI>().getFirestore().runTransaction((tx) async{
      CollectionReference col = sl.get<FirebaseAPI>().getFirestore().collection(firestoreDeletedUserListCollection);
      DocumentReference doc = col.document(sl.get<CurrentUser>().uid);
      await tx.set(doc,{
        'delete': true
      });
    }); 
  }

  Future<void> deleteUser() async {
    await sl.get<FirebaseAPI>().deleteUserAccount(sl.get<CurrentUser>().uid);
  }

  // 프로필 등록
  Future<void> registerProfile(SignUpModel data) async {
    await registerProfileIntoFirestore(data);
    await registerProfileIntoLocalDB(data);
  }

  // Cloud Firestore에 저장
  Future<void> registerProfileIntoFirestore(SignUpModel data) async {
    await sl.get<FirebaseAPI>().getFirestore().runTransaction((tx) async{
        CollectionReference collectionReference = sl.get<FirebaseAPI>().getFirestore().collection(firestoreUsersCollection);
        DocumentReference reference = collectionReference.document(sl.get<CurrentUser>().uid);
        await tx.set(reference,{
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
          firestoreIsFaceAnalyzedField: false,
        });
      });
  }

  // 로컬에 저장
  Future<void> registerProfileIntoLocalDB(SignUpModel data) async {
    Database db = await sl.get<DatabaseAPI>().database;
    db.rawInsert(
      'INSERT INTO $realProfileTable($uidCol,$nameCol,$ageCol,$jobCol,$genderCol) '
      'VALUES("${sl.get<CurrentUser>().uid}",'
      '"${data.realProfileModel.name}","${data.realProfileModel.age}",'
      '"${data.realProfileModel.job}","${data.realProfileModel.gender}")');
  }
}