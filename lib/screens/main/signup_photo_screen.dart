import 'package:flutter/material.dart';
import 'package:privacy_of_animal/logics/photo/photo.dart';
import 'package:privacy_of_animal/resources/resources.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_helpers.dart';
import 'dart:io';

class PhotoScreen extends StatefulWidget {
  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  final PhotoBloc _photoBloc = PhotoBloc();

  @override
  Widget build(BuildContext context){
    

    return Scaffold(
      appBar: AppBar(
        title: Text("사진"),
        backgroundColor: appBarColor,
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
                if(state.takedPhoto) {
                  return updatedPhoto(context, state);
                  }
                else
                  {
                    _photoBloc.emitEvent(PhotoEventTaking());
                    return Container(
                      child: SafeArea(
                        child: new CircularProgressIndicator(),
                      ),
                      height: 30.0,
                      width: 30.0,
                    );
                  }
                },
              ),

          ],
        ),
          ),
      ),
    );
  }
  
  Widget updatedPhoto (BuildContext context,PhotoState state) {
    return Column(
              mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            Container(
              height: ScreenUtil.height/3,
              width: ScreenUtil.width/1.4,
              child: SafeArea(
                child: Image.file(File(state.path))
                )
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
                color: appBarColor,
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
                _photoBloc.emitEvent(PhotoEventGotoAnalysis());
                // TODO:goto next screen
              },
              color: appBarColor,
            )
          ],
        );
  }
}
