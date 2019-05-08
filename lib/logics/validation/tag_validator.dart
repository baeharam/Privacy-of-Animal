import 'dart:async';

import 'package:privacy_of_animal/resources/strings.dart';

class TagValidator {
  final StreamTransformer<String,String> validateTag = 
      StreamTransformer<String,String>.fromHandlers(handleData: (tag, sink){
        if (tag.isEmpty){
          sink.addError(profileEmptyTagEditError);
        } else {
          sink.add(tag);
        }
      });
}