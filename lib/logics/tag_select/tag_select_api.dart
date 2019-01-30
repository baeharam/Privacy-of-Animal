import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:privacy_of_animal/resources/constants.dart';
import 'package:privacy_of_animal/resources/strings.dart';

class TagSelectAPI {
  static final Firestore _firestore = Firestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  final List<String> _tags = List<String>();

  void _extractTags(List<bool> isTagSelected) {
    for(int i=0; i<tags.length; i++){
      if(isTagSelected[i]){
        _tags.add(tags[i].title);
      }
    }
  }

  Future<TAG_STORE_RESULT> storeTags(List<bool> isTagSelected) async{
    _extractTags(isTagSelected);
    FirebaseUser user = await _auth.currentUser();
    try{
      await _firestore.runTransaction((transaction) async{
        CollectionReference collectionReference = _firestore.collection(firestoreUsersCollection);
        DocumentReference reference = collectionReference.document(user.uid);
        await reference.setData({
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

}

enum TAG_STORE_RESULT {
  SUCCESS,
  FAILURE
}