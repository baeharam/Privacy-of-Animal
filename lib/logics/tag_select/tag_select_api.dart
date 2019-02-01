import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/database_helper.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/resources/constants.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:sqflite/sqflite.dart';

class TagSelectAPI {

  void _storeTagsIntoCurrentUser(List<bool> isTagSelected) {
    for(int i=0; i<tags.length; i++){
      if(isTagSelected[i]){
        CurrentUser user = sl.get<CurrentUser>();
        user.tagListModel.tagTitleList.add(tags[i].title);
      }
    }
  }

  Future<TAG_STORE_RESULT> storeTags(List<bool> isTagSelected) async{
    _storeTagsIntoCurrentUser(isTagSelected);
    String uid = await sl.get<FirebaseAPI>().user;
    try{
      SharedPreferences prefs = await sl.get<DatabaseHelper>().sharedPreferences;
      prefs.setBool(uid+firestoreIsTagSelectedField, true);
      await _storeTagsIntoFirestore(uid);
      await _storeTagsIntoLocalDB(uid);
    }catch(exception){
      return TAG_STORE_RESULT.FAILURE;
    }
    return TAG_STORE_RESULT.SUCCESS;
  }

  Future<void> _storeTagsIntoFirestore(String uid) async {
    await sl.get<FirebaseAPI>().firestore.runTransaction((transaction) async{
        CollectionReference collectionReference = sl.get<FirebaseAPI>().firestore.collection(firestoreUsersCollection);
        DocumentReference reference = collectionReference.document(uid);
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
  }

  Future<void> _storeTagsIntoLocalDB(String uid) async {
    List<String> tags = sl.get<CurrentUser>().tagListModel.tagTitleList;
    Database db = await sl.get<DatabaseHelper>().database;
    await db.rawInsert(
      'INSERT INTO $tagTable($uidCol,$tagName1Col,$tagName2Col,$tagName3Col,$tagName4Col,$tagName5Col) '
      'VALUES("$uid","${tags[0]}","${tags[1]}","${tags[2]}","${tags[3]}","${tags[4]}")'
    );
    db.close();
  }
}

enum TAG_STORE_RESULT {
  SUCCESS,
  FAILURE
}