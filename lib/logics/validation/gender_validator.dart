import 'dart:async';

class GenderValidator {
  final StreamTransformer<String,String> validateGender = 
      StreamTransformer<String,String>.fromHandlers(handleData: (gender, sink){
        if (gender==null){
          sink.addError('');
        } else {
          sink.add(gender);
        }
      });
}