import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/models/kakao_ml_model.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:privacy_of_animal/resources/config.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';

class PhotoAPI {

  Future<String> getImage() async {
    final File image = await ImagePicker.pickImage(source: ImageSource.camera);
    final File compressedImage = await FlutterNativeImage.compressImage(image.path, quality: 80, percentage: 100);
    return compressedImage.path;
  }

  Future<ANALYZE_RESULT> analyzeFace(String photoPath) async {
    final Uri uri = Uri.parse(kakaoAPIurl);
    final http.MultipartRequest request = http.MultipartRequest('POST',uri);
    request.headers['Authorization'] = 'KakaoAK $kakaoAPIKey';
    request.files.add(await http.MultipartFile.fromPath('file', photoPath));

    http.StreamedResponse streamedResponse = await request.send();
    final http.Response response = await http.Response.fromStream(streamedResponse);
    Map<String,dynamic> firstJson = json.decode(response.body);

    if(firstJson['result']['faces']==null){
      return ANALYZE_RESULT.FAILURE;
    }

    Map<String,dynamic> realJson = firstJson['result']['faces'][0]['facial_points'];
    sl.get<CurrentUser>().kakaoMLModel = KakaoMLModel.fromJson(realJson);
    return ANALYZE_RESULT.SUCCESS;
  }
}

enum ANALYZE_RESULT {
  SUCCESS,
  FAILURE
}