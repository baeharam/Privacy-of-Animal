import 'dart:async';

class AgeValidator {
  final StreamTransformer<int,int> validateAge = 
      StreamTransformer<int,int>.fromHandlers(handleData: (age, sink){
        if (age==null){
          sink.addError(-1);
        } else {
          sink.add(age);
        }
      });
}