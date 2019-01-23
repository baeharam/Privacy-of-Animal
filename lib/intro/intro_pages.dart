import 'package:privacy_of_animal/model/intro_page_model.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/resources/strings.dart';

final pages = [
  IntroPageModel(
    backgroundColor: introColor1,
    image: 'assets/images/animals/lion.jpg',
    aboveMessage: introMessage1Above,
    belowMessage: introMessage1Below,
  ),

  IntroPageModel(
    backgroundColor: introColor2,
    image: 'assets/images/animals/bison.jpg',
    aboveMessage: introMessage2Above,
    belowMessage: introMessage2Below,
  ),
  IntroPageModel(
    backgroundColor: introColor3,
    image: 'assets/images/animals/tiger.jpg',
    aboveMessage: introMessage3Above,
    belowMessage: introMessage3Below,
  )
];