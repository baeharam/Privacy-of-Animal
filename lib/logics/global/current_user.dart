import 'package:privacy_of_animal/models/chat_list_model.dart';
import 'package:privacy_of_animal/models/chat_model.dart';
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

  Map<String,ChatListModel> chatListHistory;
  Map<String,List<ChatModel>> chatHistory;
  List<UserModel> friendsList;
  List<UserModel> requestFromList;
  int newFriendsNum;

  String currentProfileUID;
  bool isRequestTo;

  bool friendsNotification;
  Map<String,bool> chatRoomNotification;
  String currentChatUID;

  List<ChatModel> randomChat;

  void clear() {
    uid = '';

    realProfileModel = RealProfileModel();
    tagListModel = TagListModel(tagTitleList: [], tagDetailList: []);
    fakeProfileModel = FakeProfileModel();
    newFriendsNum = 0;

    chatListHistory = Map<String,ChatListModel>();
    chatHistory = Map<String,List<ChatModel>>();

    friendsList = [];
    requestFromList = [];

    currentProfileUID = '';
    isRequestTo = false;

    friendsNotification = false;
    chatRoomNotification = Map<String,bool>();
    currentChatUID = '';

    randomChat = List<ChatModel>();
  }

  CurrentUser() { clear(); }

  void initCurrentChatUID(String receiverUID) => currentChatUID = receiverUID;
  void disposeCurrentChatUID() => currentChatUID = '';
}