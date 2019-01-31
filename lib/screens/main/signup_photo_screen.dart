import 'package:flutter/material.dart';
import 'package:privacy_of_animal/logics/photo/photo.dart';
import 'package:privacy_of_animal/resources/resources.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_helpers.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter_native_image/flutter_native_image.dart';


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
      ),
      body: Center(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
            height: ScreenUtil.height/3,
            child: BlocBuilder(
              bloc: _photoBloc,
              builder: (context, PhotoState state){
                if(state.takedPhoto) {
                  _photoBloc.emitEvent(PhotoEventTakedPhoto());
                  
                  }
                else{
                  _photoBloc.emitEvent(PhotoEventNotaked());
                  return CircularProgressIndicator(
                    );
                }
                },
              )
            ),
            
            RaisedButton(
              child: Text(
                "사진 다시 찍기",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold
                ),
                ),
                onPressed: () async{
                  _photoBloc.emitEvent(PhotoEventRetaking());
                }
            ),
            RaisedButton(
              child: Text(
                "가상프로필 생성 ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold
                ),
              ),
              onPressed: () async{
                _photoBloc.emitEvent(PhotoEventGotoAnalysis());
                // TODO:goto next screen
              },
            )
          ],
        ),
          ),
      ),
    );
  }
}
