import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/database_helper.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FriendsChatAPI {

  /// [친구 알림 설정]
  Future<void> setChatRoomNotification(String chatRoomID) async {
    SharedPreferences prefs = await sl.get<DatabaseHelper>().sharedPreferences;
    bool value = !sl.get<CurrentUser>().chatRoomNotification[chatRoomID];
    prefs.setBool(chatRoomID, value);
    sl.get<CurrentUser>().chatRoomNotification[chatRoomID] = value;
  }
  

  Future<void> sendMessage(String content,String receiver,String chatRoomID) async {
    DocumentSnapshot flagDoc = await sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreFriendsMessageCollection)
      .document(chatRoomID)
      .get();

    DocumentReference chatDoc = sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreFriendsMessageCollection)
      .document(chatRoomID)
      .collection(chatRoomID)
      .document();

    await sl.get<FirebaseAPI>().getFirestore().runTransaction((tx) async{
      await tx.update(flagDoc.reference, {
        '$firestoreChatDeleteField.$receiver': false,
        '$firestoreChatDeleteField.${sl.get<CurrentUser>().uid}': false
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
}