import 'package:flutter/material.dart';
import 'package:privacy_of_animal/logics/friends/friends.dart';
import 'package:privacy_of_animal/models/user_model.dart';
import 'package:privacy_of_animal/resources/colors.dart';
import 'package:privacy_of_animal/screens/other_profile/other_profile_screen.dart';

class FriendsRequestItem extends StatelessWidget {

  final UserModel requestingUser;
  final FriendsState state;
  final FriendsBloc friendsBloc;

  FriendsRequestItem({
    @required this.requestingUser,
    @required this.state,
    @required this.friendsBloc
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
                  image: AssetImage(requestingUser.fakeProfileModel.animalImage),
                  fit: BoxFit.cover
                ),
                borderRadius: BorderRadius.circular(5.0)
              ),
            ),
            onTap: () => Navigator.push(context, MaterialPageRoute(
              builder: (context) => OtherProfileScreen(user: requestingUser)
            )),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  requestingUser.fakeProfileModel.nickName,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  requestingUser.realProfileModel.name,
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
                '수락',
                style: TextStyle(
                  color: primaryGreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0
                ),
              ),
            ),
            onTap: () => (state.isFriendsAcceptLoading || state.isFriendsRejectLoading) ? null :
              friendsBloc.emitEvent(FriendsEventAcceptFromLocal(userToAccept: requestingUser)),
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
                '삭제',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0
                ),
              ),
            ),
            onTap: () => (state.isFriendsAcceptLoading || state.isFriendsRejectLoading) ? null :
              friendsBloc.emitEvent(FriendsEventRejectFromLocal(userToReject: requestingUser)),
          )
        ],
      ),
    );
  }
}