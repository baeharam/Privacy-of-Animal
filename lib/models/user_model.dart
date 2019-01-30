import 'package:privacy_of_animal/models/signup_model.dart';
import 'package:privacy_of_animal/models/tag_list_model.dart';

class User {
  final TagList tagList;
  final SignUpModel realProfile;

  User({
    this.tagList,
    this.realProfile
  });
}