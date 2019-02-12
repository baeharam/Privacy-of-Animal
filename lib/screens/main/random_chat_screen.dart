import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:privacy_of_animal/logics/random_chat/random_chat.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/widgets/progress_indicator.dart';

class RandomChatScreen extends StatefulWidget {
  @override
  _RandomChatScreenState createState() => _RandomChatScreenState();
}

class _RandomChatScreenState extends State<RandomChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '채팅',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: primaryBlue
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: RandomChatBloc.api.getDocumentStream(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return CustomProgressIndicator();
          }
          if(snapshot.hasData){
            print(snapshot.data.documents[0].documentID);
          }
          return Container();
        },
      ),
    );
  }
}