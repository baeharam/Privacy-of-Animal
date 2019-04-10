import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state_builder.dart';
import 'package:privacy_of_animal/logics/random_loading/random_loading.dart';
import 'package:privacy_of_animal/resources/resources.dart';
import 'package:privacy_of_animal/screens/main/random_chat_screen.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';

class RandomLoadingScreen extends StatefulWidget {
  @override
  _RandomLoadingScreenState createState() => _RandomLoadingScreenState();
}

class _RandomLoadingScreenState extends State<RandomLoadingScreen> {

  final RandomLoadingBloc _randomLoadingBloc = sl.get<RandomLoadingBloc>();
  bool _isChatRoomMaker = false;

  @override
  void dispose() {
    _randomLoadingBloc.emitEvent(RandomLoadingEventStateClear());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: primaryBlue
      ),
      body: WillPopScope(
        onWillPop: () {
          if(_isChatRoomMaker){
            _randomLoadingBloc.emitEvent(RandomLoadingEventCancel());
          }
          return Future.value(true);
        },
        child: BlocBuilder(
          bloc: _randomLoadingBloc,
          builder: (context, RandomLoadingState state){
            /// [채팅방 만드는데 성공함]
            if(state.isChatRoomMadeSucceeded) {
              _isChatRoomMaker = true;
              return RandomLoadingIndicator();
            }
            /// [채팅방 들어가는데 성공함]
            if(state.isMatchSucceeded){
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => RandomChatScreen(
                    chatRoomID: state.chatRoomID,
                    receiver: state.receiver,
                  )
                ));
              });
            }
            return RandomLoadingIndicator();
          }
        )
      ),
    );  
  }
}

class RandomLoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(height: 20.0),
          Text(
            '채팅 상대를 찾고 있습니다...',
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
}