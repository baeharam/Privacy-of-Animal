import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state_builder.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/notification/notification.dart';
import 'package:privacy_of_animal/resources/resources.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  
  final NotificationBloc bloc = sl.get<NotificationBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: primaryBlue,
          title: Text(
            "알림",
            style: TextStyle(
                fontSize: ScreenUtil.width * 0.054,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        body: Container(
          child: BlocBuilder(
            bloc: bloc,
            builder: (context, NotificationState state){
              return ListView(
                scrollDirection: Axis.vertical,
                children: [
                  _buildSwitch(
                    item: AlertItem(
                      title: '친구신청',
                      titleSize: 19.0,
                      switchValue: sl.get<CurrentUser>().friendsRequestNotification
                    ),
                    onChanged: (value) => bloc.emitEvent(NotificationEventFriendsRequest(value: value))
                  ),
                  _buildSwitch(
                    item: AlertItem(
                      title: '메시지',
                      titleSize: 19.0,
                      switchValue: sl.get<CurrentUser>().messageNotification
                    ),
                    onChanged: (value) => {}
                  ),
                ],
              );
            }
          ),
        ));
  }

  Widget _buildSwitch({AlertItem item, Function onChanged}) {
    return Container(
        height: ScreenUtil.height * 0.08,
        foregroundDecoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Colors.grey[300], width: 1.1))),
        margin: EdgeInsets.fromLTRB(
            0.0, ScreenUtil.width * 0.001, .0, ScreenUtil.width * 0.002),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: ScreenUtil.width * 0.08),
              child: Text(
                item.title,
                style: TextStyle(
                  fontSize: item.titleSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: ScreenUtil.width * 0.06),
              child: Switch(
                value: item.switchValue,
                onChanged: onChanged,
              ),
            )
          ],
        ));
  }

}

class AlertItem {
  final String title;
  final double titleSize;
  final bool switchValue;
  final Icon trailing;
  final String route;

  AlertItem({
    this.title,
    this.titleSize,
    this.switchValue,
    this.trailing,
    this.route
  });
}
