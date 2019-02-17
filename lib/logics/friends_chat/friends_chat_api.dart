
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';

class FriendsChatAPI {

  Future<void> sendMessage(String content,String receiver,String chatRoomID) async {
    DocumentReference doc = sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreFriendsMessageCollection)
      .document(chatRoomID).collection(chatRoomID).document();
    await sl.get<FirebaseAPI>().getFirestore().runTransaction((tx) async{
      await tx.set(doc, {
        firestoreChatFromField: sl.get<CurrentUser>().uid,
        firestoreChatToField: receiver,
        firestoreChatContentField: content,
        firestoreChatTimestampField:FieldValue.serverTimestamp()
      });
    });
  }

}