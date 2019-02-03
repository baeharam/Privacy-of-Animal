import 'package:privacy_of_animal/models/fake_profile_model.dart';
import 'package:privacy_of_animal/models/kakao_ml_model.dart';
import 'package:privacy_of_animal/models/real_profile_model.dart';
import 'package:privacy_of_animal/models/tag_list_model.dart';

class CurrentUser {
  String uid;
  RealProfileModel realProfile;
  TagListModel tagListModel;
  KakaoMLModel kakaoMLModel;
  FakeProfileModel fakeProfileModel;

  bool isTagSelected;
  bool isTagChatted;
  bool isFaceAnalyzed;

  CurrentUser() : 
    realProfile = RealProfileModel(), 
    tagListModel = TagListModel(tagTitleList: List<String>(), tagDetailList: List<String>()),
    fakeProfileModel = FakeProfileModel();
}