import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/photo/photo.dart';
import 'package:privacy_of_animal/resources/resources.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_helpers.dart';
import 'package:privacy_of_animal/utils/back_button_dialog.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/utils/stream_snackbar.dart';
import 'dart:io';

class PhotoScreen extends StatefulWidget {

  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  final PhotoBloc _photoBloc = sl.get<PhotoBloc>();
  Widget image = Center(child: Text('사진을 찍지 않았습니다.'));
  
  @override
  Widget build(BuildContext context){

    final bool fromProfile = sl.get<CurrentUser>().fakeProfileModel.animalName!=null;

    return Scaffold(
      body: WillPopScope(
          onWillPop: () => fromProfile ? Navigator.pop(context) : BackButtonAction.stopInMiddle(context),
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
                streamSnackbar(context,'분석에 실패했습니다.');
                image = Center(child: Text('사진을 찍지 않았습니다.'));
              }
              if(state.isPhotoDone){
                image = Container(
                  height: ScreenUtil.height/1.2,
                  width: ScreenUtil.width/1.2,
                  child: FittedBox(
                    fit:BoxFit.contain,
                    child: Image.file(File(state.path))
                  )
                );
              }
              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(child: image),
                      SizedBox(height: ScreenUtil.height/18),
                      RaisedButton(
                        padding: EdgeInsets.symmetric(horizontal: ScreenUtil.width/3, vertical: ScreenUtil.height/40),
                        color: primaryPink,
                        child: Text(
                          '사진 찍기',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0
                          ),
                        ),
                        onPressed: () => _photoBloc.emitEvent(PhotoEventTaking()),
                      ),
                      SizedBox(height: 20.0),
                      BlocBuilder(
                        bloc: _photoBloc,
                        builder: (context, PhotoState state){
                          return RaisedButton(
                            padding: EdgeInsets.symmetric(horizontal: ScreenUtil.width/3, vertical: ScreenUtil.height/40),
                            color: (state.isPhotoDone) ? primaryPink : Colors.grey,
                            child: Text(
                              '분석 하기',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0
                              ),
                            ),
                            onPressed: () => (state.isPhotoDone)
                            ? _photoBloc.emitEvent(PhotoEventGotoAnalysis(photoPath: state.path)) 
                            : null
                          );
                        }
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 10.0,right: 30.0),
                        child: Text(
                          photoWarningMessage1+'\n'+photoWarningMessage2,
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          ),
      )
      );
    }
}
