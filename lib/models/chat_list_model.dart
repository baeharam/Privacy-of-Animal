
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatListModel {
  String chatRoomID;
  String profileImage;
  String nickName;
  String lastMessage;
  Timestamp lastTimestamp;
  DocumentSnapshot snapshot;

  ChatListModel({
    this.chatRoomID,
    this.profileImage,
    this.nickName,
    this.lastMessage,
    this.lastTimestamp,
    this.snapshot
  });
}