
import 'package:cloud_firestore/cloud_firestore.dart';

class SameMatchModel {
  String nickName;
  String age;
  String gender;
  String emotion;
  String animalName;
  String tagTitle;
  String tagDetail;
  String profileImage;
  double confidence;
  DocumentSnapshot userInfo;

  SameMatchModel({
    this.nickName,
    this.age,
    this.gender,
    this.emotion,
    this.animalName,
    this.tagTitle,
    this.tagDetail,
    this.profileImage,
    this.confidence,
    this.userInfo
  });
}