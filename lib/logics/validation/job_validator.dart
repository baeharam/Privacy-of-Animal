import 'dart:async';

class JobValidator {
  final StreamTransformer<String,String> validateJob = 
      StreamTransformer<String,String>.fromHandlers(handleData: (job, sink){
        if (job==null){
          sink.addError('');
        } else {
          sink.add(job);
        }
      });
}