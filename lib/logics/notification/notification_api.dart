
import 'dart:async';

import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/database_helper.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:privacy_of_animal/resources/strings.dart';

class NotificationAPI {
  
  Future<void> setFriendsRequest(bool value) async {
    SharedPreferences prefs = await sl.get<DatabaseHelper>().sharedPreferences;
    prefs.setBool(friendsRequestNotification, value);
    sl.get<CurrentUser>().friendsRequestNotification = value;
  }
}