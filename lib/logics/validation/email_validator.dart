import 'dart:async';

const String _kEmailRule = r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$";

class EmailValidator {
  final StreamTransformer<String,String> validateEmail = 
      StreamTransformer<String,String>.fromHandlers(handleData: (email, sink){
        final RegExp emailExp = new RegExp(_kEmailRule);

        if (!emailExp.hasMatch(email) || email.isEmpty){
          sink.addError('유효한 이메일을 입력하세요.');
        } else {
          sink.add(email);
        }
      });
}