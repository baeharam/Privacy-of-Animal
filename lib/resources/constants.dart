import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:privacy_of_animal/models/intro_page_model.dart';
import 'package:privacy_of_animal/models/tag_model.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/resources/strings.dart';

final double dashedCircleRadius = ScreenUtil.height/16;
final double dashedBackgroundCircleDiameter = dashedCircleRadius*2+30.0;

class ScreenUtil {
  static double width;
  static double height;
}

class CurrentPlatform {
  static TargetPlatform platform;
}

const pages = [
  const IntroPageModel(
    backgroundColor: primaryPink,
    image: 'assets/images/animals/lion.jpg',
    aboveMessage: introMessage1Above,
    belowMessage: introMessage1Below,
  ),

  IntroPageModel(
    backgroundColor: primaryGreen,
    image: 'assets/images/animals/bison.jpg',
    aboveMessage: introMessage2Above,
    belowMessage: introMessage2Below,
  ),
  IntroPageModel(
    backgroundColor: primaryBlue,
    image: 'assets/images/animals/tiger.jpg',
    aboveMessage: introMessage3Above,
    belowMessage: introMessage3Below,
  )
];

const agePickerData = '''
[
  {
    "10대":[10,11,12,13,14,15,16,17,18,19]
  },
  {
    "20대":[20,21,22,23,24,25,26,27,28,29]
  },
  {
    "30대":[30,31,32,33,34,35,36,37,38,39]
  },
  {
    "40대":[40,41,42,43,44,45,46,47,48,49]
  },
  {
    "50대":[50,51,52,53,54,55,56,57,58,59]
  }
]
''';

const tags = [
  const Tag(
    title: '예술',
    image: AssetImage('assets/images/tags/art.png')
  ),
  const Tag(
    title: '독서',
    image: AssetImage('assets/images/tags/book.png')
  ),
  const Tag(
    title: '만화',
    image: AssetImage('assets/images/tags/cartoon.png')
  ),
  const Tag(
    title: '연예인',
    image: AssetImage('assets/images/tags/celebrity.png')
  ),
  const Tag(
    title: '드라마',
    image: AssetImage('assets/images/tags/drama.png')
  ),
  const Tag(
    title: '패션',
    image: AssetImage('assets/images/tags/fashion.png')
  ),
  const Tag(
    title: '음식',
    image: AssetImage('assets/images/tags/food.png')
  ),
  const Tag(
    title: '게임',
    image: AssetImage('assets/images/tags/game.png')
  ),
  const Tag(
    title: '레저',
    image: AssetImage('assets/images/tags/leisure.png')
  ),
  const Tag(
    title: '메이크업',
    image: AssetImage('assets/images/tags/makeup.png')
  ),
  const Tag(
    title: '영화',
    image: AssetImage('assets/images/tags/movie.png')
  ),
  const Tag(
    title: '사진',
    image: AssetImage('assets/images/tags/photo.png')
  ),
  const Tag(
    title: '자취',
    image: AssetImage('assets/images/tags/single_life.png')
  ),
  const Tag(
    title: '운동',
    image: AssetImage('assets/images/tags/sport.png')
  ),
  const Tag(
    title: '음악',
    image: AssetImage('assets/images/tags/music.png')
  )
];