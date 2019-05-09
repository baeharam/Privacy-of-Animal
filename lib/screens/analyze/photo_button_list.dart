import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state_builder.dart';
import 'package:privacy_of_animal/logics/photo/photo.dart';
import 'package:privacy_of_animal/resources/resources.dart';

class ButtonList extends StatelessWidget {

  final Widget image;
  final PhotoBloc photoBloc;

  const ButtonList({
    Key key, 
    @required this.image, 
    @required this.photoBloc
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child: image),
            SizedBox(height: ScreenUtil.height/18),
            RaisedButton(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtil.width/2.8, vertical: ScreenUtil.height/40),
              color: primaryPink,
              child: Text(
                '갤러리',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0
                ),
              ),
              onPressed: () => photoBloc.emitEvent(PhotoEventFetching()),
            ),
            SizedBox(height: 20.0),
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
              onPressed: () => photoBloc.emitEvent(PhotoEventTaking()),
            ),
            SizedBox(height: 20.0),
            BlocBuilder(
              bloc: photoBloc,
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
                  ? photoBloc.emitEvent(PhotoEventGotoAnalysis(photoPath: state.path)) 
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
}