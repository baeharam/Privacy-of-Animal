import 'dart:async';

import 'package:privacy_of_animal/resources/strings.dart';

class PasswordValidator {
  final StreamTransformer<String,String> validatePassword = 
      StreamTransformer<String,String>.fromHandlers(handleData: (password, sink){
        if (password.length==0){
          sink.addError(loginEmptyPasswordError);
        } else if(password.length<6){
          sink.addError(loginInavlidPasswordError);
        } else {
          sink.add(password);
        }
      });
}