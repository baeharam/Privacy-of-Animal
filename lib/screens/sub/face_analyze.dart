import 'package:flutter/material.dart';
import 'package:privacy_of_animal/resources/resources.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_helpers.dart';
import 'package:privacy_of_animal/logics/face_analyze/face_analyze.dart';
import 'package:privacy_of_animal/widgets/arc_background_faceAnalyze.dart';




class FaceAnalyzeSub extends StatefulWidget {
  @override
  _FaceAnalyzeSubState createState() => _FaceAnalyzeSubState();
}

class _FaceAnalyzeSubState extends State<FaceAnalyzeSub>{
  FaceAnalyzeBloc _faceAnalyzeBloc = sl.get<FaceAnalyzeBloc>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Stack(
          children: <Widget>[
            ArcBackground( backgroundColor: primaryGreen,),
            //TODO: 닮은 정도를 Cicle로 그려주기.
              //TODO: 시작점을 선으로 시작하고, 끝나는 점도 선으로 그어주기
            // Positioned(
            //   left: (MediaQuery.of(context).size.width - (CurrentPlatform.platform == TargetPlatform.android ? MediaQuery.of(context).size.height/2.4: MediaQuery.of(context).size.height/3 )),
            //   top: MediaQuery.of(context).size.height/17,
            //   child: Container(
            //     width: CurrentPlatform.platform == TargetPlatform.android ? MediaQuery.of(context).size.height/2.4:  MediaQuery.of(context).size.height/3,
            //     height: CurrentPlatform.platform == TargetPlatform.android ? MediaQuery.of(context).size.height/2.4 : MediaQuery.of(context).size.height/3,       
            //     decoration: BoxDecoration(
            //       image: DecorationImage(
            //         image: AssetImage("assets/images/animals/lion.jpg"),
            //         fit: BoxFit.cover
            //       ),
            //       borderRadius: BorderRadius.all(Radius.circular(180.0)),
            //     ),
            //   ),
            // )
              
          ],)
        ],
      );
  }
}