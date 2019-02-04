import 'package:meta/meta.dart';

class NaverMLModel {
  final String gender;
  final double genderConfidence;
  final String age;
  final double ageConfidence;
  final String emotion;
  final double emotionConfidence;

  NaverMLModel({
    @required this.gender,
    @required this.genderConfidence,
    @required this.age,
    @required this.ageConfidence,
    @required this.emotion,
    @required this.emotionConfidence
  });

  factory NaverMLModel.fromJson(Map<String,dynamic> json){
    return NaverMLModel(
      gender: json['gender']['value'],
      genderConfidence: json['gender']['confidence'],
      age: json['age']['value'],
      ageConfidence: json['age']['confidence'],
      emotion: json['emotion']['value'],
      emotionConfidence: json['emotion']['confidence']
    );
  }
}

