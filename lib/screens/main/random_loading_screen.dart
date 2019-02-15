import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state_builder.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/logics/random_chat/random_chat.dart';
import 'package:privacy_of_animal/resources/resources.dart';
import 'package:privacy_of_animal/screens/main/random_chat_screen.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/utils/stream_snackbar.dart';
import 'package:privacy_of_animal/widgets/progress_indicator.dart';

class RandomLoadingScreen extends StatefulWidget {
  @override
  _RandomLoadingScreenState createState() => _RandomLoadingScreenState();
}

class _RandomLoadingScreenState extends State<RandomLoadingScreen> {

  final RandomChatBloc randomChatBloc = sl.get<RandomChatBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '매칭 상대 찾는 중...',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: primaryBlue
      ),
      body: WillPopScope(
        onWillPop: () async{
          randomChatBloc.emitEvent(RandomChatEventCancel());
          return Future.value(true);
        },
        child: BlocBuilder(
          bloc: randomChatBloc,
          builder: (context, RandomChatState state){
            if(state.isAPIFailed){
              streamSnackbar(context,state.errorMessage);
              Navigator.pop(context);
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

            if(state.isChatRoomMade || state.isMatched) {
              return StreamBuilder<DocumentSnapshot>(
                stream: sl.get<FirebaseAPI>().getFirestore()
                .collection(firestoreMessageCollection)
                .document(state.chatRoomID)
                .snapshots(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
                  if(snapshot.hasData && snapshot.data.data!=null && snapshot.data.data[firestoreChatBeginField]){
                    randomChatBloc.emitEvent(RandomChatEventUserEntered(receiver: snapshot.data.data[firestoreChatUsersField][1]));
                    if(state.isMatched){
                      WidgetsBinding.instance.addPostFrameCallback((_) async{
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => RandomChatScreen(
                            chatRoomID: snapshot.data.documentID,
                            receiver: state.receiver,
                          )
                        ));
                      });
                    }
                  }
                  return CustomProgressIndicator();
                },
              );
            }
            return CustomProgressIndicator();
          }
        )
      ),
    );
  }
}