import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state_builder.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/logics/random_loading/random_loading.dart';
import 'package:privacy_of_animal/resources/resources.dart';
import 'package:privacy_of_animal/screens/main/random_chat_screen.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';

class RandomLoadingScreen extends StatefulWidget {
  @override
  _RandomLoadingScreenState createState() => _RandomLoadingScreenState();
}

class _RandomLoadingScreenState extends State<RandomLoadingScreen> {

  final RandomLoadingBloc randomLoadingBloc = sl.get<RandomLoadingBloc>();
  bool isChatRoomMaker = false;
  String chatRoomID, receiver;

  Widget _loadingWidget() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: primaryBlue
      ),
      body: WillPopScope(
        onWillPop: () {
          if(isChatRoomMaker){
            randomLoadingBloc.emitEvent(RandomLoadingEventCancel());
          }
          return Future.value(true);
        },
        child: BlocBuilder(
          bloc: randomLoadingBloc,
          builder: (context, RandomLoadingState state){
            // 채팅방 만드는데 성공함
            if(state.isChatRoomMadeSucceeded) {
              isChatRoomMaker = true;
              return StreamBuilder<DocumentSnapshot>(
                stream: sl.get<FirebaseAPI>().getFirestore()
                .collection(firestoreRandomMessageCollection)
                .document(state.chatRoomID)
                .snapshots(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
                  if(snapshot.hasData && snapshot.data.data!=null && snapshot.data.data[firestoreChatBeginField]){
                    randomLoadingBloc.emitEvent(RandomLoadingEventUserEntered(
                      receiver: snapshot.data.data[firestoreChatUsersField][1],
                      chatRoomID: snapshot.data.documentID)
                    );
                  }
                  return _loadingWidget();
                },
              );
            }

            // 매칭 성공
            if(state.isMatchSucceeded){
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => RandomChatScreen(
                    chatRoomID: state.chatRoomID,
                    receiver: state.receiver,
                  )
                ));
              });
              randomLoadingBloc.emitEvent(RandomLoadingEventStateClear());
            }

            return _loadingWidget();
          }
        )
      ),
    );
  }
}