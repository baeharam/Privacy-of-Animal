import 'dart:async';

import 'package:privacy_of_animal/resources/strings.dart';

const String _kNameRule = r'[^\x00-\x7F]';

class NameValidator {
  final StreamTransformer<String,String> validateName = 
      StreamTransformer<String,String>.fromHandlers(handleData: (name, sink){
        final RegExp nameExp = new RegExp(_kNameRule);

        if (name.length==0){
          sink.addError(signUpEmptyNameError);
        } else if(!nameExp.hasMatch(name)){
          sink.addError(signUpInvalidNameError);
        } else {
          sink.add(name);
        }
      });
}