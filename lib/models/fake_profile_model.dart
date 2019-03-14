import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:privacy_of_animal/resources/strings.dart';

import 'package:meta/meta.dart';

class FakeProfileModel {
  String animalImage;
  String animalName;
  double animalConfidence;

  String nickName;
  String gender;
  double genderConfidence;
  String age;
  double ageConfidence;
  String emotion;
  double emotionConfidence;

  String celebrity;
  double celebrityConfidence;

  int analyzedTime;

  FakeProfileModel.fromSnapshot({@required DocumentSnapshot snapshot}) {
    animalImage = snapshot.data[firestoreFakeProfileField][firestoreAnimalImageField];
    animalName = snapshot.data[firestoreFakeProfileField][firestoreAnimalNameField];
    animalConfidence = snapshot.data[firestoreFakeProfileField][firestoreAnimalConfidenceField];

    nickName =snapshot.data[firestoreFakeProfileField][firestoreNickNameField];
    gender = snapshot.data[firestoreFakeProfileField][firestoreFakeGenderField];
    genderConfidence = snapshot.data[firestoreFakeProfileField][firestoreFakeGenderConfidenceField];
    age = snapshot.data[firestoreFakeProfileField][firestoreFakeAgeField];
    ageConfidence = snapshot.data[firestoreFakeProfileField][firestoreFakeAgeConfidenceField];
    emotion = snapshot.data[firestoreFakeProfileField][firestoreFakeEmotionConfidenceField];

    celebrity = snapshot.data[firestoreFakeProfileField][firestoreCelebrityField];
    celebrityConfidence = snapshot.data[firestoreFakeProfileField][firestoreCelebrityConfidenceField];

    analyzedTime = snapshot.data[firestoreFakeProfileField][firestoreAnalyzedTimeField]; 
  }

  FakeProfileModel({
    this.animalImage,
    this.animalName,
    this.animalConfidence,
    
    this.nickName,
    this.gender,
    this.genderConfidence,
    this.age,
    this.ageConfidence,
    this.emotion,
    this.emotionConfidence,

    this.celebrity,
    this.celebrityConfidence,
    
    this.analyzedTime
  });
}