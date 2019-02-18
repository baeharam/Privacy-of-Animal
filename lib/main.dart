import 'package:flutter/material.dart';
import 'package:privacy_of_animal/logics/initialize_api.dart';
import 'package:privacy_of_animal/resources/routes.dart';
import 'package:privacy_of_animal/screens/main/intro_screen.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/widgets/no_scroll_glow.dart';

Future<void> main() async{
  setup();
  sl.get<InitializeAPI>().appInitialize();
  runApp(PrivacyOfAnimal());
}

class PrivacyOfAnimal extends StatelessWidget {
  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp(
      title: '동물의 사생활',
      home: IntroScreen(),
      theme: ThemeData(
        splashColor: Colors.transparent,
        fontFamily: 'NanumGothic'
      ),
      routes: routes,
      debugShowCheckedModeBanner: false,
      builder: (context, child){
        return ScrollConfiguration(
          behavior: NoScrollGlow(),
          child: child,
        );
      },
    );
  }
}
