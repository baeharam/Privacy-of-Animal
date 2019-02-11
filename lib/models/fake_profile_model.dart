
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