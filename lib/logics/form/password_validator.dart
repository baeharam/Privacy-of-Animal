import 'dart:async';

class PasswordValidator {
  final StreamTransformer<String,String> validatePassword = 
      StreamTransformer<String,String>.fromHandlers(handleData: (password, sink){
        if (password.length==0){
          sink.addError('비밀번호를 입력하세요.');
        } else if(password.length<6){
          sink.addError('비밀번호는 6자리 이상입니다.');
        } else {
          sink.add(password);
        }
      });
}