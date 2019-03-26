import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:meta/meta.dart';

class TagListModel {
  List<String> tagTitleList;
  List<String> tagDetailList;
  static const int tagNum = 5;

  TagListModel.fromSnapshot({@required DocumentSnapshot snapshot}) {
    tagTitleList = List<String>(tagNum);
    tagDetailList = List<String>(tagNum);

    Map data = snapshot.data;

    tagTitleList[0] = data[firestoreTagField][firestoreTagTitle1Field];
    tagTitleList[1] = data[firestoreTagField][firestoreTagTitle2Field];
    tagTitleList[2] = data[firestoreTagField][firestoreTagTitle3Field];
    tagTitleList[3] = data[firestoreTagField][firestoreTagTitle4Field];
    tagTitleList[4] = data[firestoreTagField][firestoreTagTitle5Field];

    tagDetailList[0] = data[firestoreTagField][firestoreTagDetail1Field];
    tagDetailList[1] = data[firestoreTagField][firestoreTagDetail2Field];
    tagDetailList[2] = data[firestoreTagField][firestoreTagDetail3Field];
    tagDetailList[3] = data[firestoreTagField][firestoreTagDetail4Field];
    tagDetailList[4] = data[firestoreTagField][firestoreTagDetail5Field];
  }
  
  TagListModel({
    @required this.tagTitleList,
    @required this.tagDetailList
  });
}