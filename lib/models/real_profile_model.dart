import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:privacy_of_animal/resources/strings.dart';

class RealProfileModel {
  String name;
  String age;
  String job;
  String gender;

  RealProfileModel.fromSnapshot({@required DocumentSnapshot snapshot}) {
    name = snapshot.data[firestoreRealProfileField][firestoreNameField];
    age = snapshot.data[firestoreRealProfileField][firestoreAgeField];
    job = snapshot.data[firestoreRealProfileField][firestoreJobField];
    gender = snapshot.data[firestoreRealProfileField][firestoreGenderField];
  }

  RealProfileModel({
    this.name,
    this.age,
    this.job,
    this.gender
  });
}