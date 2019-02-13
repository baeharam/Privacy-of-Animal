import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state_builder.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/logics/random_chat/random_chat.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/screens/main/random_chat_screen.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/widgets/progress_indicator.dart';

class RandomLoadingScreen extends StatefulWidget {
  @override
  _RandomLoadingScreenState createState() => _RandomLoadingScreenState();
}

class _RandomLoadingScreenState extends State<RandomLoadingScreen> {
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
          sl.get<RandomChatBloc>().emitEvent(RandomChatEventCancel());
          return Future.value(true);
        },
        child: BlocBuilder(
          bloc: sl.get<RandomChatBloc>(),
          builder: (context, RandomChatState state){
            if(state.isLoading){
              return CustomProgressIndicator();
            }
            if(state.isCanceled){
              return Container();
            }
            return StreamBuilder(
              stream: sl.get<FirebaseAPI>().firestore.collection('messages').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                if(snapshot.hasData && snapshot.data.documentChanges.length!=0){
                  String chatRoomID = snapshot.data.documentChanges[0].document.documentID;
                  int currentUserLength = sl.get<CurrentUser>().uid.length;
                  if(chatRoomID.length==currentUserLength*2){
                    String uid1 = chatRoomID.substring(0,currentUserLength);
                    String uid2 = chatRoomID.substring(currentUserLength,currentUserLength*2);

                    bool isUID1 = uid1.compareTo(sl.get<CurrentUser>().uid)==0;
                    bool isUID2 = uid2.compareTo(sl.get<CurrentUser>().uid)==0;
                    if(isUID1 || isUID2){
                      WidgetsBinding.instance.addPostFrameCallback((_){
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => RandomChatScreen(
                            chatRoomID: chatRoomID,
                            receiver: isUID1?uid1:uid2,
                          )
                        ));
                      });
                    }
                  }
                }
                return CustomProgressIndicator();
              },
            );
          }
        )
      ),
    );
  }
}