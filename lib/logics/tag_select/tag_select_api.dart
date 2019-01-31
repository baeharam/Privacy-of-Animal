import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:privacy_of_animal/resources/constants.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/utils/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class TagSelectAPI {
  final Firestore _firestore = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final List<String> _tags = List<String>();
  Database db;

  void _extractTags(List<bool> isTagSelected) {
    for(int i=0; i<tags.length; i++){
      if(isTagSelected[i]){
        _tags.add(tags[i].title);
      }
    }
  }

  Future<TAG_STORE_RESULT> storeTagsIntoFirestore(List<bool> isTagSelected) async{
    _extractTags(isTagSelected);
    FirebaseUser user = await _auth.currentUser();
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool(user.uid+firestoreIsTagSelectedField, true);
      await _firestore.runTransaction((transaction) async{
        CollectionReference collectionReference = _firestore.collection(firestoreUsersCollection);
        DocumentReference reference = collectionReference.document(user.uid);
        await reference.updateData({
          firestoreIsTagSelectedField: true,
          firestoreTagField: {
            firestoreTagTitle1Field: _tags[0],
            firestoreTagTitle2Field: _tags[1],
            firestoreTagTitle3Field: _tags[2],
            firestoreTagTitle4Field: _tags[3],
            firestoreTagTitle5Field: _tags[4]
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