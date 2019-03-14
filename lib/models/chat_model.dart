import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:meta/meta.dart';

class ChatModel {
  String content;
  String fromUID;
  String toUID;
  DateTime timeStamp;

  ChatModel.fromSnapshot({@required DocumentSnapshot snapshot}) {
    this.content = snapshot.data[firestoreChatContentField];
    this.fromUID = snapshot.data[firestoreChatFromField];
    this.toUID = snapshot.data[firestoreChatToField];
    this.timeStamp = snapshot.data[firestoreChatTimestampField];
  }
}