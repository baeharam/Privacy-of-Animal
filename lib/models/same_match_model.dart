
import 'package:cloud_firestore/cloud_firestore.dart';

class SameMatchModel {
  String tagTitle;
  String tagDetail;
  String profileImage;
  double confidence;
  DocumentSnapshot userInfo;

  SameMatchModel({
    this.tagTitle,
    this.tagDetail,
    this.profileImage,
    this.confidence,
    this.userInfo
  });
}