import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_helpers.dart';
import 'package:privacy_of_animal/logics/photo/photo.dart';
import 'package:privacy_of_animal/screens/main/screen.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/utils/stream_snackbar.dart';
import 'package:privacy_of_animal/widgets/progress_indicator.dart';


class PhotoDecision extends StatefulWidget {
  @override
  _PhotoDecisionState createState() => _PhotoDecisionState();
}

class _PhotoDecisionState extends State<PhotoDecision> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: sl.get<PhotoBloc>(),
      builder: (BuildContext context, PhotoState state){
        if(state.isAnalyzeSucceeded){
          return Container();
        }
        return PhotoScreen();
      },
    );
  }
}