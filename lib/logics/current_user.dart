import 'package:privacy_of_animal/models/chat_list_model.dart';
import 'package:privacy_of_animal/models/fake_profile_model.dart';
import 'package:privacy_of_animal/models/kakao_ml_model.dart';
import 'package:privacy_of_animal/models/real_profile_model.dart';
import 'package:privacy_of_animal/models/tag_list_model.dart';
import 'package:privacy_of_animal/models/user_model.dart';

class CurrentUser {
  String uid;
  RealProfileModel realProfileModel;
  TagListModel tagListModel;
  KakaoMLModel kakaoMLModel;
  FakeProfileModel fakeProfileModel;

  Map<String,ChatListModel> chatHistory;
  List<UserModel> friendsList;
  List<UserModel> friendsRequestList;
  int newFriendsNum;
  bool isFirstFriendsFetch;

  bool friendsNotification;
  bool messageNotification;

  bool isDataFetched;

  CurrentUser() {
    uid = '';

    realProfileModel = RealProfileModel();
    tagListModel = TagListModel(tagTitleList: [], tagDetailList: []);
    fakeProfileModel =FakeProfileModel();

    chatHistory = Map<String,ChatListModel>();
    friendsList = [];
    friendsRequestList = [];
    newFriendsNum = 0;
    isFirstFriendsFetch = true;

    friendsNotification = false;
    messageNotification = false;

    isDataFetched = false;
  }
}