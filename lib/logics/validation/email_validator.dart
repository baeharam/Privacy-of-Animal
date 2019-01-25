import 'dart:async';

import 'package:privacy_of_animal/resources/strings.dart';

const String _kEmailRule = r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$";

class EmailValidator {
  final StreamTransformer<String,String> validateEmail = 
      StreamTransformer<String,String>.fromHandlers(handleData: (email, sink){
        final RegExp emailExp = new RegExp(_kEmailRule);

        if(email.isEmpty){
          sink.addError(loginEmptyEmailError);
        } else if (!emailExp.hasMatch(email)){
          sink.addError(loginInvalidEmailError);
        } else {
          sink.add(email);
        }
      });
}