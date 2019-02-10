
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/database_helper.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:sqflite/sqflite.dart';

class HomeAPI {
  // 바로 홈 화면으로 갈 경우 그에 해당하는 데이터를 가져옴
  Future<FETCH_RESULT> fetchUserData() async {
    try {
      String uid = sl.get<CurrentUser>().uid;
      Database db = await sl.get<DatabaseHelper>().database;

      // 태그 정보 가져오기
      List<Map<String,dynamic>> tags = 
      await db.rawQuery('SELECT * FROM $tagTable WHERE $uidCol="$uid"');
      sl.get<CurrentUser>().tagListModel.tagTitleList.add(tags[0][tagName1Col]);
      sl.get<CurrentUser>().tagListModel.tagTitleList.add(tags[0][tagName2Col]);
      sl.get<CurrentUser>().tagListModel.tagTitleList.add(tags[0][tagName3Col]);
      sl.get<CurrentUser>().tagListModel.tagTitleList.add(tags[0][tagName4Col]);
      sl.get<CurrentUser>().tagListModel.tagTitleList.add(tags[0][tagName5Col]);
      sl.get<CurrentUser>().tagListModel.tagDetailList.add(tags[0][tagDetail1Col]);
      sl.get<CurrentUser>().tagListModel.tagDetailList.add(tags[0][tagDetail2Col]);
      sl.get<CurrentUser>().tagListModel.tagDetailList.add(tags[0][tagDetail3Col]);
      sl.get<CurrentUser>().tagListModel.tagDetailList.add(tags[0][tagDetail4Col]);
      sl.get<CurrentUser>().tagListModel.tagDetailList.add(tags[0][tagDetail5Col]);

      // 실제 프로필 정보 가져오기
      List<Map<String,dynamic>> realProfile = 
      await db.rawQuery('SELECT * FROM $realProfileTable WHERE $uidCol="$uid"');
      sl.get<CurrentUser>().realProfileModel.name = realProfile[0][nameCol];
      sl.get<CurrentUser>().realProfileModel.age = realProfile[0][ageCol];
      sl.get<CurrentUser>().realProfileModel.gender = realProfile[0][genderCol];
      sl.get<CurrentUser>().realProfileModel.job = realProfile[0][jobCol];

      // 가상 프로필 정보 가져오기
      List<Map<String,dynamic>> fakeProfile = 
      await db.rawQuery('SELECT * FROM $fakeProfileTable WHERE $uidCol="$uid"');
      print(fakeProfile[0][fakeAgeCol]);
      sl.get<CurrentUser>().fakeProfileModel.nickName = fakeProfile[0][nickNameCol];
      sl.get<CurrentUser>().fakeProfileModel.age = fakeProfile[0][fakeAgeCol];
      sl.get<CurrentUser>().fakeProfileModel.gender = fakeProfile[0][fakeGenderCol];
      sl.get<CurrentUser>().fakeProfileModel.emotion = fakeProfile[0][fakeEmotionCol];
      sl.get<CurrentUser>().fakeProfileModel.ageConfidence = fakeProfile[0][fakeAgeConfidenceCol];
      sl.get<CurrentUser>().fakeProfileModel.genderConfidence = fakeProfile[0][fakeGenderConfidenceCol];
      sl.get<CurrentUser>().fakeProfileModel.emotionConfidence = fakeProfile[0][fakeEmotionConfidenceCol];
      sl.get<CurrentUser>().fakeProfileModel.animalName = fakeProfile[0][animalNameCol];
      sl.get<CurrentUser>().fakeProfileModel.animalImage = fakeProfile[0][animalImageCol];
      sl.get<CurrentUser>().fakeProfileModel.animalConfidence = fakeProfile[0][animalConfidenceCol];

      sl.get<CurrentUser>().isDataFetched = true;
    
    } catch(exception){
      return FETCH_RESULT.FAILURE;
    }
    return FETCH_RESULT.SUCCESS;
  }
}

enum FETCH_RESULT {
  SUCCESS,
  FAILURE
}