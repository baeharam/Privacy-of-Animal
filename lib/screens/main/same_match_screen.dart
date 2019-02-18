import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state_builder.dart';
import 'package:privacy_of_animal/logics/same_match/same_match.dart';
import 'package:privacy_of_animal/resources/resources.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';

class SameMatchScreen extends StatefulWidget {
  @override
  _SameMatchScreenState createState() => _SameMatchScreenState();
}

class _SameMatchScreenState extends State<SameMatchScreen> {

  final SameMatchBloc sameMatchBloc = sl.get<SameMatchBloc>();

  Widget _loadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(height: 20.0),
          Text(
            '관심사가 비슷한 상대를 찾고 있습니다...',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15.0
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: primaryBlue
      ),
      body: BlocBuilder(
        bloc: sameMatchBloc,
        builder: (context, SameMatchState state){
          if(state.isLoading){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                Text('관심사가 비슷한 상대를 찾는 중입니다...')
              ],
            );
          }
          if(state.isFindSucceeded) {
            return Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    CircularPercentIndicator(
                      radius: ScreenUtil.width/2.8,
                      percent: state.sameMatchModel.confidence,
                      lineWidth: 10.0,
                      progressColor: primaryBeige,
                    ),
                    CircleAvatar(
                      backgroundImage: AssetImage(state.sameMatchModel.profileImage),
                      radius: ScreenUtil.width/6.2,
                    )
                  ],
                )
              ],
            );
          }
        }
      ),
    );
  }
}