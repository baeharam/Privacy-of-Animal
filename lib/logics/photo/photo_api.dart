import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/database_helper.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/models/animal_model.dart';
import 'package:privacy_of_animal/models/fake_profile_model.dart';
import 'package:privacy_of_animal/models/kakao_ml_model.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:privacy_of_animal/models/naver_ml_model.dart';
import 'package:privacy_of_animal/resources/config.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class PhotoAPI {

  Future<String> getImageFromCamera() async {
    final File image = await ImagePicker.pickImage(source: ImageSource.camera);
    File compressedImage;
    if(image!=null){
      compressedImage = await FlutterNativeImage.compressImage(image.path, quality: 80, percentage: 100);
      return compressedImage.path;
    }
    return '';
  }

  Future<String> getImageFromGallery() async {
    final File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    File compressedImage;
    if(image!=null){
      compressedImage = await FlutterNativeImage.compressImage(image.path, quality: 80, percentage: 100);
      return compressedImage.path;
    }
    return '';
  }

  Future<void> setFlags() async {
    String uid = sl.get<CurrentUser>().uid;

    // SharedPreferences 업데이트
    SharedPreferences prefs = await sl.get<DatabaseHelper>().sharedPreferences;
    await prefs.setBool(uid+isFaceAnalyzed,true);

    int now = DateTime.now().millisecondsSinceEpoch;

    // Cloud Firestore 업데이트
    CollectionReference collectionReference = sl.get<FirebaseAPI>().getFirestore().collection(firestoreUsersCollection);
    DocumentReference reference = collectionReference.document(sl.get<CurrentUser>().uid);
    await reference.setData({
      firestoreIsFaceAnalyzedField: true,
      firestoreFakeProfileField: {
        firestoreAnalyzedTimeField: now
      }
    },merge: true);

    // 로컬 DB 업데이트
    Database db = await sl.get<DatabaseHelper>().database;
    await db.rawUpdate(
      'UPDATE $fakeProfileTable SET $analyzedTimeCol=? WHERE $uidCol="${sl.get<CurrentUser>().uid}"',
      ['$now']
    );

    // 현재 사용자 정보 업데이트
    sl.get<CurrentUser>().fakeProfileModel.analyzedTime = now;
  }

  Future<void> storeProfile() async {
    await _storeProfileIntoFirestore();
    if(await _checkLocalDB()) {
      await _updateProfileIntoLocalDB();
    }
    else {
      await _storeProfileIntoLocalDB();
    }
  }

  Future<void> _storeProfileIntoFirestore() async {
    await sl.get<FirebaseAPI>().getFirestore().runTransaction((transaction) async{
      CollectionReference collectionReference = sl.get<FirebaseAPI>().getFirestore().collection(firestoreUsersCollection);
      DocumentReference reference = collectionReference.document(sl.get<CurrentUser>().uid);
      FakeProfileModel fakeProfileModel = sl.get<CurrentUser>().fakeProfileModel;
      await reference.setData({
        firestoreFakeProfileField: {
          firestoreFakeGenderField: fakeProfileModel.gender,
          firestoreFakeGenderConfidenceField: fakeProfileModel.genderConfidence,
          firestoreFakeAgeField: fakeProfileModel.age,
          firestoreFakeAgeConfidenceField: fakeProfileModel.ageConfidence,
          firestoreFakeEmotionField: fakeProfileModel.emotion,
          firestoreFakeEmotionConfidenceField: fakeProfileModel.emotionConfidence,
          firestoreAnimalNameField: fakeProfileModel.animalName,
          firestoreAnimalImageField: fakeProfileModel.animalImage,
          firestoreAnimalConfidenceField: fakeProfileModel.animalConfidence,
          firestoreCelebrityField: fakeProfileModel.celebrity,
          firestoreCelebrityConfidenceField: fakeProfileModel.celebrityConfidence
        },
      }, merge: true);
    });
  }

  Future<void> _storeProfileIntoLocalDB() async {
    DocumentSnapshot doc = 
    await sl.get<FirebaseAPI>().getFirestore().collection(firestoreUsersCollection).document(sl.get<CurrentUser>().uid).get();
    String nickName = doc[firestoreFakeProfileField][firestoreNickNameField];
    Database db = await sl.get<DatabaseHelper>().database;
    FakeProfileModel fakeProfileModel = sl.get<CurrentUser>().fakeProfileModel;
    await db.rawInsert(
      'INSERT INTO $fakeProfileTable'
      '($uidCol,$nickNameCol,$fakeGenderCol,$fakeGenderConfidenceCol,'
      '$fakeAgeCol,$fakeAgeConfidenceCol,$fakeEmotionCol,$fakeEmotionConfidenceCol,'
      '$animalNameCol,$animalImageCol,$animalConfidenceCol,$celebrityCol,$celebrityConfidenceCol) '
      'VALUES("${sl.get<CurrentUser>().uid}",'
      '"$nickName",'
      '"${fakeProfileModel.gender}",'
      '"${fakeProfileModel.genderConfidence}",'
      '"${fakeProfileModel.age}",'
      '"${fakeProfileModel.ageConfidence}",'
      '"${fakeProfileModel.emotion}",'
      '"${fakeProfileModel.emotionConfidence}",'
      '"${fakeProfileModel.animalName}",'
      '"${fakeProfileModel.animalImage}",'
      '"${fakeProfileModel.animalConfidence}",'
      '"${fakeProfileModel.celebrity}",'
      '"${fakeProfileModel.celebrityConfidence}")'
    );
  }

  Future<void> _updateProfileIntoLocalDB() async {
    Database db = await sl.get<DatabaseHelper>().database;
    FakeProfileModel fakeProfileModel = sl.get<CurrentUser>().fakeProfileModel;
    await db.update(fakeProfileTable, {
      fakeGenderCol: fakeProfileModel.gender,
      fakeGenderConfidenceCol: fakeProfileModel.genderConfidence,
      fakeAgeCol: fakeProfileModel.age,
      fakeAgeConfidenceCol: fakeProfileModel.ageConfidence,
      fakeEmotionCol: fakeProfileModel.emotion,
      fakeEmotionConfidenceCol: fakeProfileModel.emotionConfidence,
      animalNameCol: fakeProfileModel.animalName,
      animalImageCol: fakeProfileModel.animalImage,
      animalConfidenceCol: fakeProfileModel.animalConfidence,
      celebrityCol: fakeProfileModel.celebrity,
      celebrityConfidenceCol: fakeProfileModel.celebrityConfidence
    }, where: '$uidCol="${sl.get<CurrentUser>().uid}"');
  }

  Future<bool> _checkLocalDB() async {
    Database db = await sl.get<DatabaseHelper>().database;
    var result = await db.query(fakeProfileTable,where: '$uidCol="${sl.get<CurrentUser>().uid}"');
    return result.isNotEmpty;
  }

  // 카카오 얼굴인식
  Future<void> analyzeFaceKakao(String photoPath) async {
    final Uri uri = Uri.parse(kakaoAPIurl);
    final http.MultipartRequest request = http.MultipartRequest('POST',uri);
    request.headers['Authorization'] = 'KakaoAK $kakaoAPIKey';
    request.files.add(await http.MultipartFile.fromPath('file', photoPath));

    http.StreamedResponse streamedResponse = await request.send();
    final http.Response response = await http.Response.fromStream(streamedResponse);
    Map<String,dynamic> firstJson = json.decode(response.body);

    if(firstJson['result']['faces']==null) throw Exception();

    Map<String,dynamic> realJson = firstJson['result']['faces'][0]['facial_points'];
    sl.get<CurrentUser>().kakaoMLModel = KakaoMLModel.fromJson(realJson);
  }

  // 네이버 얼굴인식
  Future<void> analyzeFaceNaver(String photoPath) async {
    final Uri uri = Uri.parse(naverFaceAPIurl);
    final http.MultipartRequest request = http.MultipartRequest('POST',uri);
    request.headers['X-Naver-Client-Id'] = naverClientID;
    request.headers['X-Naver-Client-Secret'] = naverClientSecret;
    request.files.add(await http.MultipartFile.fromPath('image', photoPath));

    http.StreamedResponse streamedResponse = await request.send();
    final http.Response response = await http.Response.fromStream(streamedResponse);
    Map<String,dynamic> resultJson = json.decode(response.body);

    if((resultJson['faces'] as List).length==0) throw Exception();

    NaverMLModel naverMLModel = NaverMLModel.fromJson(resultJson['faces'][0]);
    sl.get<CurrentUser>().fakeProfileModel.age = naverMLModel.age;
    sl.get<CurrentUser>().fakeProfileModel.ageConfidence = naverMLModel.ageConfidence;

    sl.get<CurrentUser>().fakeProfileModel.gender 
      = naverMLModel.gender.compareTo('male')==0 ? '남자' : '여자';
    sl.get<CurrentUser>().fakeProfileModel.genderConfidence = naverMLModel.genderConfidence;

    String emotion = '';
    switch(naverMLModel.emotion){
      case 'angry': emotion='화난'; break;
      case 'disgust': emotion='역겨운'; break;
      case 'fear': emotion='두려운'; break;
      case 'laugh': emotion='웃는'; break;
      case 'neutral': emotion='무표정'; break;
      case 'sad': emotion='슬픈'; break;
      case 'surprise': emotion='놀란'; break;
      case 'smile': emotion='미소띤'; break;
      case 'talking': emotion='말하는'; break;
    }
    sl.get<CurrentUser>().fakeProfileModel.emotion = emotion;
    sl.get<CurrentUser>().fakeProfileModel.emotionConfidence = naverMLModel.emotionConfidence;
  }

  // 네이버 유명인 인식
  Future<void> analyzeCelebrityNaver(String photoPath) async {
    final Uri uri = Uri.parse(naverCelebrityAPIurl);
    final http.MultipartRequest request = http.MultipartRequest('POST',uri);
    request.headers['X-Naver-Client-Id'] = naverClientID;
    request.headers['X-Naver-Client-Secret'] = naverClientSecret;
    request.files.add(await http.MultipartFile.fromPath('image', photoPath));

    http.StreamedResponse streamedResponse = await request.send();
    final http.Response response = await http.Response.fromStream(streamedResponse);
    Map<String,dynamic> resultJson = json.decode(response.body);

    if((resultJson['faces'] as List).length==0) throw Exception();

    sl.get<CurrentUser>().fakeProfileModel.celebrity = resultJson['faces'][0]['celebrity']['value'];
    sl.get<CurrentUser>().fakeProfileModel.celebrityConfidence = resultJson['faces'][0]['celebrity']['confidence'];
  }

  Future<void> detectAnimal(KakaoMLModel data) async {
    double faceWidthValue = (data.jaw[0][0]-data.jaw[16][0]).abs();
    double faceLengthValue = (data.leftEyebrow[4][1]-data.jaw[8][1]).abs();
    double noseWidthValue = (data.nose[4][0]-data.nose[8][0]).abs();
    double noseLengthValue = (data.nose[0][1]-data.nose[3][1]).abs();
    double lipWidthValue = (data.lip[0][0]-data.lip[5][0]).abs();
    double lipLengthValue = (data.lip[3][1]-data.lip[9][1]).abs();

    
    // 얼굴 너비
    WIDTH faceWidth;
    if(faceWidthValue>=0.4) faceWidth = WIDTH.WIDE;
    else if(faceWidthValue>=0.3 && faceWidthValue<0.4) faceWidth = WIDTH.NORMAL;
    else if(faceWidthValue<0.3) faceWidth = WIDTH.NARROW;

    // 얼굴 길이
    LENGTH faceLength;
    if(faceLengthValue>=0.5) faceLength = LENGTH.LONG;
    else if(faceLengthValue>=0.4 && faceLengthValue<0.5) faceLength = LENGTH.NORMAL;
    else if(faceLengthValue<0.4) faceLength = LENGTH.SHORT;

    // 코 너비
    WIDTH noseWidth;
    if(noseWidthValue>=0.09) noseWidth = WIDTH.WIDE;
    else if(noseWidthValue>=0.08 && noseWidthValue<0.09) noseWidth = WIDTH.NORMAL;
    else if(noseWidthValue<0.08) noseWidth = WIDTH.NARROW;

    // 코 길이
    LENGTH noseLength;
    if(noseLengthValue>=0.2) noseLength =  LENGTH.LONG;
    else if(noseLengthValue>=0.1 && noseLengthValue<0.2) noseLength = LENGTH.NORMAL;
    else if(noseLengthValue<0.1) noseLength = LENGTH.SHORT;

    // 입술 너비
    WIDTH lipWidth;
    if(lipWidthValue>=0.14) lipWidth = WIDTH.WIDE;
    else if(lipWidthValue>=0.13 && lipWidthValue<0.14) lipWidth = WIDTH.NORMAL;
    else if(lipWidthValue<0.13) lipWidth = WIDTH.NARROW;

    // 입술 길이
    LENGTH lipLength; 
    if(lipLengthValue>=0.07) lipLength = LENGTH.LONG;
    else if(lipLengthValue>=0.06 && lipLengthValue<0.07) lipLength = LENGTH.NORMAL;
    else if(lipLengthValue<0.06) lipLength = LENGTH.SHORT;
    
    List<List<Animal>> candidate = List.generate(7, (_) => List<Animal>());
    animalList.forEach((animal){
      int matchNum = 0;
      if(animal.faceWidth==faceWidth) matchNum++;
      if(animal.faceLength==faceLength) matchNum++;
      if(animal.noseWidth==noseWidth) matchNum++;
      if(animal.noseLength==noseLength) matchNum++;
      if(animal.lipWidth==lipWidth) matchNum++;
      if(animal.lipLength==lipLength) matchNum++;
      candidate[matchNum].add(animal);
    });

    Random random = Random();
    int len = 0,index=0;
    while(len==0){
      index = random.nextInt(7);
      len = candidate[index].length;
    }
    Animal animal = candidate[index][random.nextInt(candidate[index].length)];
    sl.get<CurrentUser>().fakeProfileModel.animalImage = animal.image;
    sl.get<CurrentUser>().fakeProfileModel.animalName = animal.name;
    sl.get<CurrentUser>().fakeProfileModel.animalConfidence 
      = (candidate[index].length/animalList.length) + (index*0.1);
    if(sl.get<CurrentUser>().fakeProfileModel.animalConfidence>1.0)
      sl.get<CurrentUser>().fakeProfileModel.animalConfidence = 1.0;
  }
}