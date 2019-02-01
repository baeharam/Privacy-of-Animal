import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/database_helper.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:sqflite/sqflite.dart';

class TagChatAPI {

  Database _db;
  String _uid;

  Future<TAG_CHECK_RESULT> checkLoaclDB() async {
    try {
      _db = await sl.get<DatabaseHelper>().database;
      _uid = await sl.get<FirebaseAPI>().user;

      List<Map<String,dynamic>> queryResult = 
      await _db.rawQuery('SELECT * FROM $tagTable WHERE $uidCol="$_uid"');
      print(queryResult);

      if(queryResult.length==0){
        _callFirestoreSetLocalDB();
      }
      else{
        _setCurrentUser([
          queryResult[0][tagName1Col],
          queryResult[0][tagName2Col],
          queryResult[0][tagName3Col],
          queryResult[0][tagName4Col],
          queryResult[0][tagName5Col]
        ]);
      }
    } catch(exception){
      print(exception);
      return TAG_CHECK_RESULT.FAILURE;
    }
    return TAG_CHECK_RESULT.SUCCESS;
  }

  Future<void> _callFirestoreSetLocalDB() async {
    List<String> tags;
    DocumentSnapshot snapshot = await sl.get<FirebaseAPI>().firestore.collection(firestoreUsersCollection).document(_uid).get();
    tags = snapshot[firestoreTagField];
    await _db.rawInsert(
      'INSERT INTO $tagTable($uidCol,$tagName1Col,$tagName2Col,$tagName3Col,$tagName4Col,$tagName5Col) '
      'VALUES("$_uid","${tags[0]}","${tags[1]}","${tags[2]}","${tags[3]}","${tags[4]}")'
    );
    _setCurrentUser(tags);
  }

  void _setCurrentUser(List<String> tags){
    sl.get<CurrentUser>().tagListModel.tagTitleList.addAll(tags);
  }
}

enum TAG_CHECK_RESULT{
  SUCCESS,
  FAILURE
}