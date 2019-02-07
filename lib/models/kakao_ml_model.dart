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
    Map<String,List<List<double>>> ans =  Map<String,List<List<double>>>();
    json.forEach((key,value){
      List<dynamic> firstList = json[key] as List;
      List<List<double>> realList = List<List<double>>();
      firstList.forEach((item){
        List<dynamic> secondList = item as List;
        List<double> realItem = List<double>();
        secondList.forEach((item2){
          realItem.add(item2 as double);
        });
        realList.add(realItem);
      });
      ans[key] = realList;
    });

    return KakaoMLModel(
      jaw: ans['jaw'],
      rightEyebrow: ans['right_eyebrow'],
      leftEyebrow: ans['left_eyebrow'],
      nose: ans['nose'],
      rightEye: ans['right_eye'],
      leftEye: ans['left_eye'],
      lip: ans['lip']
    );
  }
}