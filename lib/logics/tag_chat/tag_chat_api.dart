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
  List<String> _tagDetails;

  Future<TAG_DETAIL_STORE_RESULT> storeTagDetail() async {
    try{
      await _storeTagDetailIntoFirestore();
      await _storeTagDetailIntoLocalDB();
    }catch(exception){
      print(exception);
      return TAG_DETAIL_STORE_RESULT.FAILURE;
    }
    return TAG_DETAIL_STORE_RESULT.SUCCESS;
  }

  Future<void> _storeTagDetailIntoFirestore() async {
    _tagDetails = sl.get<CurrentUser>().tagListModel.tagDetailList;
    await sl.get<FirebaseAPI>().firestore.collection(firestoreUsersCollection).document(_uid)
    .setData(
      {
        firestoreTagField: {
          firestoreTagDetail1Field: _tagDetails[0],
          firestoreTagDetail2Field: _tagDetails[1],
          firestoreTagDetail3Field: _tagDetails[2],
          firestoreTagDetail4Field: _tagDetails[3],
          firestoreTagDetail5Field: _tagDetails[4],
        }
      },
      merge: true
    );
  }

  Future<void> _storeTagDetailIntoLocalDB() async {
    await _db.rawInsert(
      'INSERT INTO $tagTable($tagDetail1Col,$tagDetail2Col,$tagDetail3Col,$tagDetail4Col,$tagDetail5Col) '
      'VALUES("${_tagDetails[0]}","${_tagDetails[1]}","${_tagDetails[2]}","${_tagDetails[3]}","${_tagDetails[4]}")'
    );
  }

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
        _setCurrentUserTagTitle([
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
    Map map = snapshot.data[firestoreTagField];
    map.forEach((key,value) => tags.add(map[key]));
    await _db.rawInsert(
      'INSERT INTO $tagTable($uidCol,$tagName1Col,$tagName2Col,$tagName3Col,$tagName4Col,$tagName5Col) '
      'VALUES("$_uid","${tags[0]}","${tags[1]}","${tags[2]}","${tags[3]}","${tags[4]}")'
    );
    _setCurrentUserTagTitle(tags);
  }

  void _setCurrentUserTagTitle(List<String> tags){
    sl.get<CurrentUser>().tagListModel.tagTitleList.addAll(tags);
  }
}

enum TAG_CHECK_RESULT{
  SUCCESS,
  FAILURE
}

enum TAG_DETAIL_STORE_RESULT{
  SUCCESS,
  FAILURE
}