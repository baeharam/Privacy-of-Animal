
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/resources/constants.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';

class TagEditAPI {
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