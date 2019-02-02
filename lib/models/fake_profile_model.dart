import 'package:meta/meta.dart';

class FakeProfileModel {
  final String image;
  final String animalName;
  final double animalConfidence;

  FakeProfileModel({
    @required this.image,
    @required this.animalName,
    @required this.animalConfidence
  });
}