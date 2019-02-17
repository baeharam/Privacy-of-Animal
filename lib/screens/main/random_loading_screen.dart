import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state_builder.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/logics/random_chat/random_chat.dart';
import 'package:privacy_of_animal/resources/resources.dart';
import 'package:privacy_of_animal/screens/main/random_chat_screen.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/utils/stream_snackbar.dart';

class RandomLoadingScreen extends StatefulWidget {
  @override
  _RandomLoadingScreenState createState() => _RandomLoadingScreenState();
}

class _RandomLoadingScreenState extends State<RandomLoadingScreen> {

  final RandomChatBloc randomChatBloc = sl.get<RandomChatBloc>();
  bool isChatRoomMaker = false;

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
            randomChatBloc.emitEvent(RandomChatEventCancel());
          }
          return Future.value(true);
        },
        child: BlocBuilder(
          bloc: randomChatBloc,
          builder: (context, RandomChatState state){
            if(state.isAPIFailed){
              streamSnackbar(context,state.errorMessage);
            }

            if(state.isMatched){
              WidgetsBinding.instance.addPostFrameCallback((_){
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => RandomChatScreen(
                    chatRoomID: state.chatRoomID,
                    receiver: state.receiver,
                  )
                ));
              });
            }

            if(state.isChatRoomMade) {
              isChatRoomMaker = true;
              return StreamBuilder<DocumentSnapshot>(
                stream: sl.get<FirebaseAPI>().getFirestore()
                .collection(firestoreRandomMessageCollection)
                .document(state.chatRoomID)
                .snapshots(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
                  if(snapshot.hasData && snapshot.data.data!=null && snapshot.data.data[firestoreChatBeginField]){
                    randomChatBloc.emitEvent(RandomChatEventUserEntered(
                      receiver: snapshot.data.data[firestoreChatUsersField][1],
                      chatRoomID: snapshot.data.documentID)
                    );
                  }
                  return _loadingWidget();
                },
              );
            }

            if(state.isMatched){
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => RandomChatScreen(
                    chatRoomID: state.chatRoomID,
                    receiver: state.receiver,
                  )
                ));
              });
            }

            return _loadingWidget();
          }
        )
      ),
    );
  }
}