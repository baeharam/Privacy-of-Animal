import 'package:flutter/material.dart';
import 'package:privacy_of_animal/model/intro_page_model.dart';

class IntroPage extends StatelessWidget {

  final IntroPageModel introPageModel;

  IntroPage({this.introPageModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height*0.7,
      color: introPageModel.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: Column(
              children: <Widget>[
                Text(
                  introPageModel.aboveMessage,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  introPageModel.belowMessage,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                  ),
                ),
                SizedBox(height: 30.0),
                Container(
                  width: 300.0,
                  height: 300.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(introPageModel.image),
                      fit: BoxFit.cover
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(150.0)),
                    border: Border.all(color: Colors.white,width: 4.0)
                  )
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}