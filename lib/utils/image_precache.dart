import 'package:flutter/widgets.dart';
import 'package:privacy_of_animal/resources/constants.dart';


Future<void> imagePrecache(BuildContext context) async{
  for(int i=0; i<tags.length; i++){
    precacheImage(AssetImage(tags[i].image), context);
  }
}