import 'dart:async';

import 'package:privacy_of_animal/resources/strings.dart';

class NameValidator {
  final StreamTransformer<String,String> validateName = 
      StreamTransformer<String,String>.fromHandlers(handleData: (name, sink){
        if (name.length==0){
          sink.addError(signUpEmptyNameError);
        } else {
          sink.add(name);
        }
      });
}