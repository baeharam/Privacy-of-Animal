
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';

class HomeAPI {

  Future<FETCH_RESULT> fetchData() async {
    try {
      String uid = sl.get<CurrentUser>().uid;
      CollectionReference cr = sl.get<FirebaseAPI>().firestore.collection(firestoreUsersCollection);
      DocumentSnapshot ds = await cr.document(uid).get();
      Map tags = ds.data[firestoreTagField];
      Map realProfile = ds.data[firestoreRealProfileField];
      Map fakeProfile = ds.data[firestoreFakeProfileField];

      sl.get<CurrentUser>().tagListModel.tagTitleList.add(tags[firestoreTagTitle1Field]);
      sl.get<CurrentUser>().tagListModel.tagTitleList.add(tags[firestoreTagTitle2Field]);
      sl.get<CurrentUser>().tagListModel.tagTitleList.add(tags[firestoreTagTitle3Field]);
      sl.get<CurrentUser>().tagListModel.tagTitleList.add(tags[firestoreTagTitle4Field]);
      sl.get<CurrentUser>().tagListModel.tagTitleList.add(tags[firestoreTagTitle5Field]);
    }
  } 
}

enum FETCH_RESULT {
  SUCCESS,
  FAILURE
}