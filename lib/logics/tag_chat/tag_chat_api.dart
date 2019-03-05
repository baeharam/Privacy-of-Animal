import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/database_helper.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class TagChatAPI {

  static const int introDelayTime = 600;
  static const int chatDelayTime = 400;
  int npcChatListIndex = 0;
  List<String> _tagDetails;

  void saveUserAnswer(String answer) {
    sl.get<CurrentUser>().tagListModel.tagDetailList.add(answer);
  }

  Future<void> storeTagDetail() async {
    await _storeTagDetailIntoFirestore();
    await _storeTagDetailIntoLocalDB();
    SharedPreferences sharedPreferences = await sl.get<DatabaseHelper>().sharedPreferences;
    sharedPreferences.setBool(sl.get<CurrentUser>().uid+isTagChatted, true);
  }

  // Cloud Firestore에 태그 상세 저장
  Future<void> _storeTagDetailIntoFirestore() async {
    _tagDetails = sl.get<CurrentUser>().tagListModel.tagDetailList;
    await sl.get<FirebaseAPI>().getFirestore().collection(firestoreUsersCollection).document(sl.get<CurrentUser>().uid)
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
    Database db = await sl.get<DatabaseHelper>().database;
    await db.rawUpdate(
      'UPDATE $tagTable SET $tagDetail1Col=?,$tagDetail2Col=?,$tagDetail3Col=?,$tagDetail4Col=?,$tagDetail5Col=? '
      'WHERE $uidCol="${sl.get<CurrentUser>().uid}"',
      ['${_tagDetails[0]}','${_tagDetails[1]}','${_tagDetails[2]}','${_tagDetails[3]}','${_tagDetails[4]}']
    );
  }

  // 현재 사용자가 태그 이름 정보를 가지고 있는지 체크한 후 없으면
  // 로컬 DB에서 가져와서 세팅.
  Future<void> checkLoaclDBandFetch() async {
    if(sl.get<CurrentUser>().tagListModel.tagTitleList.length!=5) {
      Database db = await sl.get<DatabaseHelper>().database;
      db = await sl.get<DatabaseHelper>().database;

      List<Map<String,dynamic>> queryResult = 
      await db.rawQuery('SELECT * FROM $tagTable WHERE $uidCol="${sl.get<CurrentUser>().uid}"');
      _setCurrentUserTagTitle([
        queryResult[0][tagName1Col],
        queryResult[0][tagName2Col],
        queryResult[0][tagName3Col],
        queryResult[0][tagName4Col],
        queryResult[0][tagName5Col]
      ]);
    }
  }

  // 현재 사용자에 태그 상세 저장
  void _setCurrentUserTagTitle(List<String> tags){
    sl.get<CurrentUser>().tagListModel.tagTitleList.addAll(tags);
  }
}