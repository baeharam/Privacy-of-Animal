import 'package:privacy_of_animal/models/real_profile_model.dart';
import 'package:privacy_of_animal/models/tag_list_model.dart';

class CurrentUser {
  String uid;
  RealProfileModel realProfile;
  TagListModel tagListModel;

  bool isTagSelected;
  bool isTagChatted;
  bool isFaceAnalyzed;

  CurrentUser() : 
    realProfile = RealProfileModel(), 
    tagListModel = TagListModel(tagTitleList: List<String>(), tagDetailList: List<String>());
}