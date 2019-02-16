
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatListModel {
  String profileImage;
  String nickName;
  String lastMessage;
  Timestamp lastTimestamp;

  ChatListModel({
    this.profileImage,
    this.nickName,
    this.lastMessage,
    this.lastTimestamp
  });
}