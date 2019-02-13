import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/logics/random_chat/random_chat.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/widgets/progress_indicator.dart';

class RandomChatScreen extends StatefulWidget {

  final String chatRoomID;
  final String receiver;

  RandomChatScreen({@required this.chatRoomID,@required this.receiver});

  @override
  _RandomChatScreenState createState() => _RandomChatScreenState();
}

class _RandomChatScreenState extends State<RandomChatScreen> {

  final ScrollController scrollController = ScrollController();
  final TextEditingController messageController = TextEditingController();
  final FocusNode messageFocusNode = FocusNode();
  final RandomChatBloc randomChatBloc = sl.get<RandomChatBloc>();

  // Cloud Firestore? ?? ???? ???? ??.
  List<String> messages = List<String>();

  bool isFirstLeft = false;
  bool isFirstRight = false;

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
    messageFocusNode.dispose();
    scrollController.dispose();
  }

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
      body: WillPopScope(
        onWillPop: (){
          randomChatBloc.emitEvent(RandomChatEventInitial());
          return Future.value(true);
        },
        child: Column(
          children: <Widget>[
            Flexible(
              child: StreamBuilder(
                stream: sl.get<FirebaseAPI>().firestore
                  .collection('messages')
                  .document(widget.chatRoomID)
                  .collection(widget.chatRoomID)
                  .orderBy('timestamp',descending: true)
                  .limit(20)
                  .snapshots(),
                builder: (context, snapshot){
                  if(!snapshot.hasData){
                    return CustomProgressIndicator();
                  } else {
                    messages = snapshot.data.documents;
                    return ListView.builder(
                      padding: EdgeInsets.all(10.0),
                      itemBuilder: (context,index) => _buildMessage(snapshot.data.documents[index]),
                      itemCount: snapshot.data.documents.length,
                      reverse: true,
                      controller: scrollController,
                    );
                  }
                }
              ),
            ),
            Flexible(
              child: Container(
                child: TextField(
                  style: TextStyle(color: primaryGreen, fontSize: 15.0),
                  decoration: InputDecoration.collapsed(
                    hintText: '???? ?????.',
                    hintStyle: TextStyle(color: Colors.grey)
                  ),
                  controller: messageController,
                  focusNode: messageFocusNode,
                ),
              ),
            ),
            Material(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => randomChatBloc.emitEvent(
                    RandomChatEventMessageSend(
                      content: messageController.text,
                      receiver: widget.receiver,
                      chatRoomID: widget.chatRoomID
                    )
                  ),
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMessage(DocumentSnapshot document) {
    if(document['From'] == sl.get<CurrentUser>().uid){
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            child: Text(
              document['content'],
              style: TextStyle(color: primaryGreen),
            ),
            padding: EdgeInsets.fromLTRB(15.0,10.0,15.0,10.0),
            width: 200.0,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(3.0)
            ),
            margin: EdgeInsets.only(bottom: 10.0, right: 10.0),
          )
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              document['content'],
              style: TextStyle(color: Colors.white),
            ),
            padding: EdgeInsets.fromLTRB(15.0,10.0,15.0,10.0),
            width: 200.0,
            decoration: BoxDecoration(
              color: primaryBeige,
              borderRadius: BorderRadius.circular(8.0)
            ),
            margin: EdgeInsets.only(left: 10.0)
          ),
        ],
      );
    }
  }
}