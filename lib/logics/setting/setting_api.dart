

import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';

class SettingAPI {

  Future<void> logout() async {
    await sl.get<FirebaseAPI>().getAuth().signOut();
  }

}