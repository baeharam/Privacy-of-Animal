
import 'package:cloud_firestore/cloud_firestore.dart';

class TagSelectAPI {
  static final Firestore _firestore = Firestore.instance;

  Future<TAG_STORE_RESULT> storeTags(String uid)

}

enum TAG_STORE_RESULT {
  SUCCESS,
  FAILURE
}