import 'package:meta/meta.dart';

class KakaoMLModel {
  final List<List<double>> jaw;
  final List<List<double>> rightEyebrow;
  final List<List<double>> leftEyebrow;
  final List<List<double>> nose;
  final List<List<double>> rightEye;
  final List<List<double>> leftEye;
  final List<List<double>> lip;

  KakaoMLModel({
    @required this.jaw,
    @required this.rightEyebrow,
    @required this.leftEyebrow,
    @required this.nose,
    @required this.rightEye,
    @required this.leftEye,
    @required this.lip
  });

  factory KakaoMLModel.fromJson(Map<String,dynamic> json) {
    print(json['jaw']);
    return KakaoMLModel(
      jaw: json['jaw'],
      rightEyebrow: json['rightEyebrow'],
      leftEyebrow: json['leftEyebrow'],
      nose: json['nose'],
      rightEye: json['rightEye'],
      leftEye: json['leftEye'],
      lip: json['lip']
    );
  }
}