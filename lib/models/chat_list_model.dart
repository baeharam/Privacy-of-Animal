import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:privacy_of_animal/models/user_model.dart';

class ChatListModel {
  String chatRoomID;
  String profileImage;
  String nickName;
  String lastMessage;
  Timestamp lastTimestamp;
  UserModel user;

  ChatListModel({
    this.chatRoomID: '',
    this.profileImage: '',
    this.nickName: '',
    this.lastMessage: '',
    this.lastTimestamp,
    this.user
  });
}