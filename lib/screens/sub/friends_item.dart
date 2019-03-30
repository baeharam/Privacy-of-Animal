import 'package:flutter/material.dart';
import 'package:privacy_of_animal/logics/friends/friends.dart';
import 'package:privacy_of_animal/models/user_model.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/screens/main/other_profile_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class FriendsItem extends StatelessWidget {

  final UserModel friends;
  final FriendsState state;
  final FriendsBloc friendsBloc;
  final BuildContext context;

  FriendsItem({
    @required this.friends,
    @required this.state,
    @required this.friendsBloc,
    @required this.context
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
      child: Row(
        children: [
          GestureDetector(
            child: Container(
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(friends.fakeProfileModel.animalImage),
                  fit: BoxFit.cover
                ),
                borderRadius: BorderRadius.circular(5.0)
              ),
            ),
            onTap: () => Navigator.push(context, MaterialPageRoute(
              builder: (context) => OtherProfileScreen(user: friends)
            )),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  friends.fakeProfileModel.nickName,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  friends.realProfileModel.name,
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
              decoration: BoxDecoration(
                border: Border.all(color: primaryGreen),
                borderRadius: BorderRadius.circular(5.0)
              ),
              child: Text(
                '대화',
                style: TextStyle(
                  color: primaryGreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0
                ),
              ),
            ),
            onTap: () => (state.isFriendsChatLoading || state.isFriendsBlockLoading) ? null :
              friendsBloc.emitEvent(FriendsEventChat(user: friends)),
          ),
          SizedBox(width: 10.0),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
                borderRadius: BorderRadius.circular(5.0)
              ),
              child: Text(
                '차단',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0
                ),
              ),
            ),
            onTap: ()  => (state.isFriendsChatLoading || state.isFriendsBlockLoading) ? null :
              _showAlertForBlock()
          )
        ],
      ),
    );
  }

  void _showAlertForBlock() {
    Alert(
      context: context,
      title: '정말로 차단하시겠습니까?',
      desc: '상대방의 친구 목록에서\n삭제되며 모든 대화가 사라집니다.',
      type: AlertType.warning,
      buttons: [
        DialogButton(
          onPressed: (){
            friendsBloc.emitEvent(FriendsEventBlockFromLocal(userToBlock: friends));
            Navigator.pop(context);
          },
          child: Text(
            '예',
            style: TextStyle(
              color: Colors.black
            ),
          ),
          color: primaryPink,
        ),
        DialogButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            '아니오',
            style: TextStyle(
              color: Colors.black
            ),
          ),
          color: primaryBeige,
        )
      ]
    ).show();
  }
}

