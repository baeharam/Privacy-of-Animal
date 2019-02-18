
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/database_helper.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:sqflite/sqflite.dart';

class FriendsChatAPI {

  Future<Timestamp> getDeleteTimestamp(String chatroomID) async {
    DocumentSnapshot doc = await sl.get<FirebaseAPI>().getFirestore().collection(firestoreFriendsMessageCollection)
      .document(chatroomID).get();
    return doc.data[firestoreChatOutField][sl.get<CurrentUser>().uid];
  }

  Future<void> sendMessage(String content,String receiver,String chatRoomID) async {

    DocumentSnapshot flagDoc = await sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreFriendsMessageCollection)
      .document(chatRoomID).get();

    DocumentReference chatDoc = sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreFriendsMessageCollection)
      .document(chatRoomID).collection(chatRoomID).document();

    await sl.get<FirebaseAPI>().getFirestore().runTransaction((tx) async{
      await tx.update(flagDoc.reference, {
        '$firestoreChatDeleteField.${flagDoc.data[firestoreChatUsersField][0]}': false,
        '$firestoreChatDeleteField.${flagDoc.data[firestoreChatUsersField][1]}': false
      });
    });

    await sl.get<FirebaseAPI>().getFirestore().runTransaction((tx) async{
      await tx.set(chatDoc, {
        firestoreChatFromField: sl.get<CurrentUser>().uid,
        firestoreChatToField: receiver,
        firestoreChatContentField: content,
        firestoreChatTimestampField: FieldValue.serverTimestamp()
      });
    });
  }

  Future<void> storeIntoLocalDB(String from, String to, int timestamp, String content) async {
    Database db = await sl.get<DatabaseHelper>().database;
    db.rawInsert('INSERT INTO $friendsMessagesTable($fromCol,$toCol,$timeStampCol,$contentCol) '
    'VALUES($from,$to,$timestamp,$content)');
  }

}