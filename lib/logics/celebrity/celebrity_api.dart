
import 'dart:convert';

import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/resources/resources.dart';
import 'package:privacy_of_animal/resources/config.dart';
import 'package:http/http.dart' as http;

class CelebrityAPI {
  Future<GET_IMAGE_RESULT> getImageFromInternet() async {
    String keyword = sl.get<CurrentUser>().fakeProfileModel.celebrity;
    final Uri url = Uri.parse('$naverSearchAPIurl$keyword');
    final http.Request request = http.Request('GET',url);
    request.headers['X-Naver-Client-Id'] = naverClientID;
    request.headers['X-Naver-Client-Secret'] = naverClientSecret;
    http.StreamedResponse streamedResponse = await request.send();

    final response = await http.Response.fromStream(streamedResponse);
    final Map jsonData = json.decode(response.body);
    
  }

  List<String> getImageUrl(Map json) {
    List<String> imageUrls = List<String>();
    (json['items'] as List).forEach((imageMap){
      String imageLink = imageMap['thumbnail'];
      List<String> splitData = imageLink.split('src=');
      splitData = splitData[1].split('&');
      imageUrls.add(splitData[0]);
    });
    return imageUrls;
  }
}

enum GET_IMAGE_RESULT {
  SUCCESS,
  FAILURE
}