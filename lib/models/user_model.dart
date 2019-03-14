import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:privacy_of_animal/models/fake_profile_model.dart';
import 'package:privacy_of_animal/models/real_profile_model.dart';
import 'package:privacy_of_animal/models/tag_list_model.dart';

import 'package:meta/meta.dart';

class UserModel {
  String uid;
  RealProfileModel realProfileModel;
  FakeProfileModel fakeProfileModel;
  TagListModel tagListModel;

  UserModel.fromSnapshot({@required DocumentSnapshot snapshot}) {
    uid = snapshot.documentID;
    realProfileModel = RealProfileModel.fromSnapshot(snapshot: snapshot);
    fakeProfileModel = FakeProfileModel.fromSnapshot(snapshot: snapshot);
    tagListModel =TagListModel.fromSnapshot(snapshot: snapshot);
  }
}