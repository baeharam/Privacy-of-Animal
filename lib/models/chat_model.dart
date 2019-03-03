import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  DocumentSnapshot receiver;
  String myMessage;
  Timestamp myTimestamp;

  ChatModel({
    this.receiver,
    this.myMessage,
    this.myTimestamp
  });
}