import 'dart:async';

import 'package:privacy_of_animal/resources/strings.dart';

class AgeValidator {
  final StreamTransformer<String,String> validateAge = 
      StreamTransformer<String,String>.fromHandlers(handleData: (age, sink){
        if (int.parse(age)>80){
          sink.addError(signUpRangeAgeError);
        } else if (age.length==0){
          sink.addError(signUpEmptyAgeError);
        } else {
          sink.add(age);
        }
      });
}