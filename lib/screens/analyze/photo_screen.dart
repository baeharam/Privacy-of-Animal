import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:privacy_of_animal/logics/global/current_user.dart';
import 'package:privacy_of_animal/logics/photo/photo.dart';
import 'package:privacy_of_animal/resources/resources.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_helpers.dart';
import 'package:privacy_of_animal/screens/analyze/photo_button_list.dart';
import 'package:privacy_of_animal/utils/back_button_dialog.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/utils/bloc_snackbar.dart';
import 'dart:io';

class PhotoScreen extends StatefulWidget {

  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  
  final PhotoBloc _photoBloc = sl.get<PhotoBloc>();
  Widget image = Center(child: Text('사진이 없습니다.'));

  @override
  void initState() {
    super.initState();
    _photoBloc.emitEvent(PhotoEventStateClear());
  }
  
  @override
  Widget build(BuildContext context){

    final bool fromProfile = sl.get<CurrentUser>().fakeProfileModel.animalName!=null;

    return Scaffold(
      body: WillPopScope(
          onWillPop: () => fromProfile 
            ? Navigator.pop(context) 
            : BackButtonAction.stopInMiddle(context),
          child: BlocBuilder(
            bloc: _photoBloc,
            builder: (context, PhotoState state){
              if(state.isLoading){
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularPercentIndicator(
                        radius: ScreenUtil.width/2.5,
                        percent: state.percentage,
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        '분석중입니다...',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0
                        ),  
                      )
                    ],
                  ),
                );
              }
              if(state.isAnalyzeFailed){
                BlocSnackbar.show(context,'분석에 실패했습니다.');
                image = Center(child: Text('사진이 없습니다.'));
              }
              if(state.isPhotoDone){
                if(state.path.isEmpty){
                  image = Center(child: Text('사진이 없습니다.'));
                }
                else {
                  image = Container(
                    height: ScreenUtil.height/1.2,
                    width: ScreenUtil.width/1.2,
                    child: FittedBox(
                      fit:BoxFit.contain,
                      child: Image.file(File(state.path))
                    )
                  );
                }
              }
              return ButtonList(image: image, photoBloc: _photoBloc);
            }
          ),
      )
      );
    }
}