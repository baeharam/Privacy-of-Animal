import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_helpers.dart';
import 'package:privacy_of_animal/logics/random_chat/random_chat.dart';
import 'package:privacy_of_animal/screens/main/random_chat_screen.dart';
import 'package:privacy_of_animal/screens/main/random_loading_screen.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';


class RandomDecision extends StatefulWidget {
  @override
  _RandomDecisionState createState() => _RandomDecisionState();
}

class _RandomDecisionState extends State<RandomDecision> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: sl.get<RandomChatBloc>(),
      builder: (BuildContext context, RandomChatState state){
        if(state.isMatched) {
          return RandomChatScreen(chatRoomID: state.chatRoomID,receiver: state.receiver);
        }
        return RandomLoadingScreen();
      },
    );
  }
}