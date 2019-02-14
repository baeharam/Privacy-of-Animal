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

  final RandomChatBloc chatBloc = sl.get<RandomChatBloc>();

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
          chatBloc.emitEvent(RandomChatEventCancel());
          return Future.value(true);
        },
        child: BlocBuilder(
          bloc: chatBloc,
          builder: (context, RandomChatState state){
            if(state.apiFailed){
              streamSnackbar(context,state.errorMessage);
              return Container();
            }

            return StreamBuilder<DocumentSnapshot>(
              stream: sl.get<FirebaseAPI>().getFirestore()
              .collection(firestoreMessageCollection)
              .document(state.chatRoomID)
              .snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
                if(!snapshot.hasData){
                  return CustomProgressIndicator();
                } else if(snapshot.data[firestoreChatBeginField]){
                  WidgetsBinding.instance.addPostFrameCallback((_){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => RandomChatScreen(
                        chatRoomID: snapshot.data.documentID,
                        receiver: snapshot.data[firestoreChatUsersField][0]==sl.get<CurrentUser>().uid ? 
                        snapshot.data[firestoreChatUsersField][1] : snapshot.data[firestoreChatUsersField][0],
                      )
                    ));
                  });
                }
              },
            );
          }
        )
      ),
    );
  }
}