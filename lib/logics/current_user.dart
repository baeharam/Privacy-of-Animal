import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:privacy_of_animal/models/fake_profile_model.dart';
import 'package:privacy_of_animal/models/kakao_ml_model.dart';
import 'package:privacy_of_animal/models/real_profile_model.dart';
import 'package:privacy_of_animal/models/tag_list_model.dart';

class CurrentUser {
  String uid;
  RealProfileModel realProfileModel;
  TagListModel tagListModel;
  KakaoMLModel kakaoMLModel;
  FakeProfileModel fakeProfileModel;

  List<DocumentSnapshot> friendsList;
  List<DocumentSnapshot> friendsRequestList;
  int friendsListLength;
  int friendsRequestListLength;

  bool friendsNotification;
  bool messageNotification;

  bool isDataFetched;

  void clear() {
    uid = '';
    realProfileModel = RealProfileModel();
    tagListModel = TagListModel(tagTitleList: [], tagDetailList: []);
    fakeProfileModel = FakeProfileModel();

    friendsList = friendsRequestList = [];
    friendsListLength =friendsRequestListLength = -1;

    friendsNotification =messageNotification = false;
    isDataFetched = false;
  }

  CurrentUser() {
    clear();
  }
}