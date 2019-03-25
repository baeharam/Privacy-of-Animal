import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:privacy_of_animal/resources/strings.dart';

class ChatModel {
  String from;
  String to;
  String content;
  Timestamp timeStamp;

  ChatModel.fromSnapshot({@required DocumentSnapshot snapshot}) {
    this.from = snapshot.data[firestoreChatFromField];
    this.to = snapshot.data[firestoreChatToField];
    this.content = snapshot.data[firestoreChatContentField];
    this.timeStamp = snapshot.data[firestoreChatTimestampField];
  }
}