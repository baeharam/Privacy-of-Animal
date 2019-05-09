import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:privacy_of_animal/logics/global/current_user.dart';
import 'package:privacy_of_animal/models/chat_model.dart';
import 'package:privacy_of_animal/models/user_model.dart';
import 'package:privacy_of_animal/screens/other_profile/other_profile_screen.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';

class ChatBuilder {

  List<ChatModel> _messages;
  UserModel receiver;
  BuildContext context;

  ChatBuilder({
    @required this.receiver,
    @required this.context
  }) : assert(receiver!=null),
       assert(context!=null);

  set messages(List<ChatModel> messages) => _messages = messages;
  int get messageLength => _messages.length;

  Widget _buildMine(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        _isLastRight(index) ?
        Container(
          margin: EdgeInsets.only(right: 10.0,bottom: 5.0),
          child: Text(
            DateFormat('kk:mm','ko')
              .format(DateTime.fromMillisecondsSinceEpoch(_messages[index].timeStamp.millisecondsSinceEpoch)),
              style: TextStyle(color: Colors.grey,fontSize: 12.0),
          ),
        ) : Container(),
        Flexible(
          child: Column(
            children: <Widget>[
              SizedBox(height: 5.0),
              Container(
                child: Text(
                  _messages[index].content,
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
                padding: EdgeInsets.fromLTRB(15.0,10.0,15.0,10.0),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(3.0)
                ),
                margin: _isLastRight(index) ? const EdgeInsets.only(right: 10.0,bottom: 5.0)
                  : const EdgeInsets.only(right: 10.0),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildYours(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        _isFirstLeft(index) ?
        Column(
          children: [
            Text(
              receiver.fakeProfileModel.nickName,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600
              ),
            ),
            SizedBox(height: 5.0),
            Container(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: GestureDetector(
              child: CircleAvatar(
                backgroundImage: AssetImage(receiver.fakeProfileModel.animalImage),
                backgroundColor: Colors.transparent,
              ),
              onTap: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) => OtherProfileScreen(user: receiver)
              )),
            ))
          ]
        ) : Container(width: 40.0),
        Flexible(
          child: Container(
            child: Text(
              _messages[index].content,
              style: TextStyle(color: Colors.white),
            ),
            padding: EdgeInsets.fromLTRB(15.0,10.0,15.0,10.0),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(8.0)
            ),
            margin: EdgeInsets.only(left: 10.0,bottom: 5.0)
          ),
        ),
        _isLastLeft(index) ?
        Container(
        margin: EdgeInsets.only(left: 10.0,bottom: 5.0),
        child: Text(
          DateFormat('kk:mm','ko')
            .format(DateTime.fromMillisecondsSinceEpoch(_messages[index].timeStamp.millisecondsSinceEpoch)),
            style: TextStyle(color: Colors.grey,fontSize: 12.0),
        ),
        ) : Container()
      ],
    );
  }

  Widget buildMessage(int index) {
    if(_messages[index].from == sl.get<CurrentUser>().uid){
      return _buildMine(index);
    } else {
      return _buildYours(index);
    }
  }

  bool _isFirstLeft(int index) {
    if((index<_messages.length-1 && _messages!=null && _messages[index+1].from == sl.get<CurrentUser>().uid)
     || (index == _messages.length-1)) {
       return true;
     } else {
       return false;
     }
  }

  bool _isLastLeft(int index) {
    if((index>0 && _messages!=null && _messages[index-1].from == sl.get<CurrentUser>().uid) 
      || index==0){
        return true;
    } else {
      return false;
    }
  }

  bool _isLastRight(int index) {
    if((index>0 && _messages!=null && _messages[index-1].to == sl.get<CurrentUser>().uid) 
      || index==0){
        return true;
    } else {
      return false;
    }
  }
}