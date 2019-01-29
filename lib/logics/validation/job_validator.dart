import 'dart:async';

import 'package:privacy_of_animal/resources/strings.dart';

const String _kJobRule = r'[^\x00-\x7F]';

class JobValidator {
  final StreamTransformer<String,String> validateJob = 
      StreamTransformer<String,String>.fromHandlers(handleData: (job, sink){
        final RegExp jobExp = new RegExp(_kJobRule);

        if (job.length==0){
          sink.addError(signUpEmptyJobError);
        } else if(!jobExp.hasMatch(job)){
          sink.addError(signUpInvalidJobError);
        } else {
          sink.add(job);
        }
      });
}