import 'dart:async';

import 'package:privacy_of_animal/resources/strings.dart';

class JobValidator {
  final StreamTransformer<String,String> validateJob = 
      StreamTransformer<String,String>.fromHandlers(handleData: (job, sink){
        if (job.length==0){
          sink.addError(signUpEmptyJobError);
        } else {
          sink.add(job);
        }
      });
}