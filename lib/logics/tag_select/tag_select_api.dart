import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/resources/constants.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';

class TagSelectAPI {

  void _extractTags(List<bool> isTagSelected) {
    for(int i=0; i<tags.length; i++){
      if(isTagSelected[i]){
        sl.get<CurrentUser>().tagListModel.tagTitleList.add(tags[i].title);
      }
    }
  }

  Future<TAG_STORE_RESULT> storeTagsIntoFirestore(List<bool> isTagSelected) async{
    _extractTags(isTagSelected);
    FirebaseUser user = await sl.get<FirebaseAPI>().auth.currentUser();
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool(user.uid+firestoreIsTagSelectedField, true);
      await sl.get<FirebaseAPI>().firestore.runTransaction((transaction) async{
        CollectionReference collectionReference = sl.get<FirebaseAPI>().firestore.collection(firestoreUsersCollection);
        DocumentReference reference = collectionReference.document(user.uid);
        await reference.updateData({
          firestoreIsTagSelectedField: true,
          firestoreTagField: {
            firestoreTagTitle1Field: sl.get<CurrentUser>().tagListModel.tagTitleList[0],
            firestoreTagTitle2Field: sl.get<CurrentUser>().tagListModel.tagTitleList[1],
            firestoreTagTitle3Field: sl.get<CurrentUser>().tagListModel.tagTitleList[2],
            firestoreTagTitle4Field: sl.get<CurrentUser>().tagListModel.tagTitleList[3],
            firestoreTagTitle5Field: sl.get<CurrentUser>().tagListModel.tagTitleList[4]
          }
        });
      });
    }catch(exception){
      return TAG_STORE_RESULT.FAILURE;
    }
    return TAG_STORE_RESULT.SUCCESS;
  }

  // Future<int> _storeTagsIntoLocalDB() async {
  //   var result = await db.rawInsert(
  //     'INSERT INTO $tagTable ($tagName1Col,$tagName2Col,$tagName3Col,$tagName4Col,$tagName5Col) '
  //     'VALUES (${_tags[0]},${_tags[1]},${_tags[2]},${_tags[3]},${_tags[4]})'
  //   );
  //   return result;
  // }

  // Future<bool> _checkTagsLocalDB() async {
  //  db = await _databaseHelper.database;
  //   var result = await db.rawQuery(
  //     'SELECT ($tagName1Col,$tagName2Col,$tagName3Col,$tagName4Col,$tagName5Col) FROM $tagTable WHERE $uidCol={$us}'
  //   );
  // }

}

enum TAG_STORE_RESULT {
  SUCCESS,
  FAILURE
}