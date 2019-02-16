
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/models/chat_list_model.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/resources/strings.dart';

class ChatListAPI {

  Future<List<ChatListModel>> fetchUserData(List<DocumentSnapshot> documents) async {
    List<ChatListModel> result = List<ChatListModel>();

    for(DocumentSnapshot doc in documents) {
      String uid = doc.data[firestoreChatUsersField][0]
        ==sl.get<CurrentUser>().uid ? doc.data[firestoreChatUsersField][1] 
        :doc.data[firestoreChatUsersField][1];
      DocumentSnapshot userData = await sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreUsersCollection)
      .document(uid).get();

      QuerySnapshot chatData = await doc.reference.collection(doc.documentID)
      .orderBy(firestoreChatTimestampField,descending: true).limit(1).getDocuments();

      ChatListModel chatListModel = ChatListModel(
        chatRoomID: doc.documentID,
        profileImage: userData.data[firestoreFakeProfileField][firestoreAnimalImageField],
        nickName: userData.data[firestoreFakeProfileField][firestoreNickNameField],
        lastMessage: chatData.documents[0].data[firestoreChatContentField],
        lastTimestamp: chatData.documents[0].data[firestoreChatTimestampField],
        snapshot: userData
      );
      result.add(chatListModel);
    }
    return result;
  }

}