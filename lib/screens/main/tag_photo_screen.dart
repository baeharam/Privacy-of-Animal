import 'package:flutter/material.dart';
import 'package:privacy_of_animal/logics/photo/photo.dart';
import 'package:privacy_of_animal/resources/resources.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_helpers.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'dart:io';


class PhotoScreen extends StatefulWidget {
  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  final PhotoBloc _photoBloc = sl.get<PhotoBloc>();
  String photoPath;
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("사진"),
        backgroundColor: primaryBlue,
        automaticallyImplyLeading: false,
      ),
      body: Center(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder(
              bloc: _photoBloc,
              builder: (context, PhotoState state){
                if(state.isPhotoDone) {
                  photoPath = state.path;
                  return Container(
                    height: ScreenUtil.height/3,
                    // width: ScreenUtil.width/1.4,
                    child: FittedBox(
                      // child: Text(state.path),
                      fit:BoxFit.contain,
                      child: Image.file(
                        File(state.path),
                        // fit:BoxFit.fitHeight,
                        // height: height,
                        )
                      )
                    );
                  
                  }
                else
                  {
                    _photoBloc.emitEvent(PhotoEventTaking());
                    return Container(
                      child: SafeArea(
                        child: new CircularProgressIndicator(),
                      ),
                      height: ScreenUtil.height/10,
                      width: ScreenUtil.height/10,
                    );
                  }
                },
              ),
              SizedBox(
                height: ScreenUtil.height/17
              ),
              RaisedButton(
                child: Text(
                  "사진 다시 찍기",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600
                  ),
                  ),
                  onPressed: () => _photoBloc.emitEvent(PhotoEventTaking()),
                  color: primaryBeige,
              ),
            RaisedButton(
              child: Text(
                "가상프로필 생성 ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600
                ),
              ),
              onPressed: () async{
                _photoBloc.emitEvent(PhotoEventGotoAnalysis(photoPath: photoPath));
                // TODO:goto next screen
              },
              color: primaryBeige,
            )

          ],
        ),
          ),
      ),
    );
  }
  

}
