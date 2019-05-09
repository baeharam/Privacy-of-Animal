
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/database_api.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/resources/resources.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:sqflite/sqflite.dart';

class TagEditAPI {


  Future<TAG_EDIT_RESULT> editTag(String tagTitle, String tagDetail, int index) async
  {
    try{
      await editTagOfFirestore(tagTitle, tagDetail, index);
      await editTagOfLocalDB(tagTitle, tagDetail, index);
      editTagOfCurrentUser(tagTitle, tagDetail, index);
    }catch(exception){
      print(exception);
      return TAG_EDIT_RESULT.FAILURE;
    }
    return TAG_EDIT_RESULT.SUCCESS;
  }

  // 현재 사용자 정보 수정
  void editTagOfCurrentUser(String tagTitle, String tagDetail, int index) {
    sl.get<CurrentUser>().tagListModel.tagTitleList[index] = tagTitle;
    sl.get<CurrentUser>().tagListModel.tagDetailList[index] = tagDetail;
  }

  // Cloud Firestore 값 수정
  Future<void> editTagOfFirestore(String tagTitle, String tagDetail, int index) async{
    DocumentReference doc = 
      sl.get<FirebaseAPI>().getFirestore().collection(firestoreUsersCollection).document(sl.get<CurrentUser>().uid);
    await doc.setData({
      firestoreTagField: {
        firestoreTagTitleList[index]: tagTitle,
        firestoreTagDetailList[index]: tagDetail
      }
    }, merge: true);
  }

  // 로컬 DB 값 수정
  Future<void> editTagOfLocalDB(String tagTitle, String tagDetail, int index) async {
    Database db = await sl.get<DatabaseAPI>().database;
    await db.rawUpdate(
      'UPDATE $tagTable SET ${tagTitleList[index]}=?, ${tagDetailList[index]}=? '
      'WHERE $uidCol="${sl.get<CurrentUser>().uid}"',
      [tagTitle,tagDetail]
    );
  }


  List<String> filterTags(int tagIndex) {
    List<String> dropDownItems = List<String>();
    List<String> userTagList = sl.get<CurrentUser>().tagListModel.tagTitleList;
    String currentTag = sl.get<CurrentUser>().tagListModel.tagTitleList[tagIndex];
    bool isAlreadyExist = false;
    tags.forEach((tag){
      for(final String userTag in userTagList){
        if(userTag.compareTo(currentTag)!=0 && tag.title.compareTo(userTag)==0){
          isAlreadyExist = true;
          break;
        }
      }
      if(!isAlreadyExist){
        dropDownItems.add(tag.title);
      }
      else{
        isAlreadyExist = false;
      }
    });
    return dropDownItems;
  }
}

enum TAG_EDIT_RESULT {
  SUCCESS,
  FAILURE
}