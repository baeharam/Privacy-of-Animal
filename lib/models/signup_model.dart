import 'package:privacy_of_animal/models/real_profile_model.dart';

class SignUpModel {
  String email;
  String password;
  RealProfileModel realProfileModel;

  SignUpModel({
    this.email,
    this.password,
    this.realProfileModel
  });
}