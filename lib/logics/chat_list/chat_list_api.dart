
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/models/chat_list_model.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/resources/strings.dart';

class ChatListAPI {

  Future<List<ChatListModel>> fetchUserData(List<DocumentSnapshot> documents) async {
    List<ChatListModel> result = List<ChatListModel>();
    documents.forEach((doc) async{
      DocumentSnapshot userData = await sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreUsersCollection)
      .document(doc.documentID).get();

      QuerySnapshot chatData = await doc.reference.collection(doc.documentID)
      .orderBy(firestoreChatTimestampField,descending: true).limit(1).getDocuments();

      ChatListModel chatListModel = ChatListModel(
        profileImage: userData.data[firestoreFakeProfileField][firestoreAnimalImageField],
        nickName: userData.data[firestoreFakeProfileField][firestoreNickNameField],
        lastMessage: chatData.documents[0].data[firestoreChatContentField],
        lastTimestamp: chatData.documents[0].data[firestoreChatTimestampField]
      );
      result.add(chatListModel);
    });
    return result;
  }

}