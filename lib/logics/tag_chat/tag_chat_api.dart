import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/database_helper.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class TagChatAPI {

  Database _db;
  List<String> _tagDetails;

  Future<TAG_DETAIL_STORE_RESULT> storeTagDetail() async {
    try{
      SharedPreferences sharedPreferences = await sl.get<DatabaseHelper>().sharedPreferences;
      sharedPreferences.setBool(sl.get<CurrentUser>().uid+isTagChatted, true);
      await _storeTagDetailIntoFirestore();
      await _storeTagDetailIntoLocalDB();
    }catch(exception){
      print(exception);
      return TAG_DETAIL_STORE_RESULT.FAILURE;
    }
    return TAG_DETAIL_STORE_RESULT.SUCCESS;
  }

  // Cloud Firestore에 태그 상세 저장
  Future<void> _storeTagDetailIntoFirestore() async {
    _tagDetails = sl.get<CurrentUser>().tagListModel.tagDetailList;
    await sl.get<FirebaseAPI>().firestore.collection(firestoreUsersCollection).document(sl.get<CurrentUser>().uid)
    .setData(
      {
        firestoreIsTagChattedField: true,
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

  // 로컬 DB에 태그 상세 저장
  Future<void> _storeTagDetailIntoLocalDB() async {
    await _db.rawInsert(
      'INSERT INTO $tagTable($uidCol,$tagDetail1Col,$tagDetail2Col,$tagDetail3Col,$tagDetail4Col,$tagDetail5Col) '
      'VALUES("${sl.get<CurrentUser>().uid}","${_tagDetails[0]}","${_tagDetails[1]}","${_tagDetails[2]}","${_tagDetails[3]}","${_tagDetails[4]}")'
    );
  }

  // 현재 사용자가 태그 이름 정보를 가지고 있는지 체크한 후 없으면
  // 로컬 DB에서 가져와서 세팅.
  Future<TAG_CHECK_RESULT> checkLoaclDB() async {
    if(sl.get<CurrentUser>().tagListModel.tagTitleList.length!=0)
      return TAG_CHECK_RESULT.SUCCESS;
    try {
      _db = await sl.get<DatabaseHelper>().database;

      List<Map<String,dynamic>> queryResult = 
      await _db.rawQuery('SELECT * FROM $tagTable WHERE $uidCol="${sl.get<CurrentUser>().uid}"');
      _setCurrentUserTagTitle([
        queryResult[0][tagName1Col],
        queryResult[0][tagName2Col],
        queryResult[0][tagName3Col],
        queryResult[0][tagName4Col],
        queryResult[0][tagName5Col]
      ]);
    } catch(exception){
      print(exception);
      return TAG_CHECK_RESULT.FAILURE;
    }
    return TAG_CHECK_RESULT.SUCCESS;
  }

  // 현재 사용자에 태그 상세 저장
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