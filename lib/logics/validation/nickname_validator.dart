import 'dart:async';

import 'package:privacy_of_animal/resources/strings.dart';
class NickNameValidator {
  final StreamTransformer<String,String> validateNickName = 
      StreamTransformer<String,String>.fromHandlers(handleData: (nickName, sink){
        if (nickName.length==0){
          sink.addError(signUpEmptyNickNameError);
        } else {
          sink.add(nickName);
        }
      });
}