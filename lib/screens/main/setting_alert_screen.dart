import 'package:flutter/material.dart';
import 'package:privacy_of_animal/resources/resources.dart';
import 'package:privacy_of_animal/logics/initialize_api.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';

class SettingAlertScreen extends StatefulWidget {
  @override
  _SettingAlertScreenState createState() => _SettingAlertScreenState();
}

class _SettingAlertScreenState extends State<SettingAlertScreen> {
  final List<AlertItem> items = AlertItem.items();
  @override
  Widget build(BuildContext context) {
    sl.get<InitializeAPI>().constantInitialize(context);
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
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              if (items[index].isSwitch)
                return _containSwitch(items[index]);
              else
                return _uncontainSwitch(items[index]);
            },
          ),
        ));
  }

  Widget _containSwitch(AlertItem item) {
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
                //blocbuilder로 value는 blocstate를 stream 하면 될듯.
                value: item.switchValue,
                // onChanged: _bloc.emitEvent(items[index].blocEvent)
              ),
            )
          ],
        ));
  }

  Widget _uncontainSwitch(AlertItem item) {
    return Container(
        height: ScreenUtil.height * 0.08,
        foregroundDecoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Colors.grey[300], width: 1.1))),
        margin: EdgeInsets.fromLTRB(
            0.0, ScreenUtil.width * 0.001, .0, ScreenUtil.width * 0.002),
        child: ListTile(
          contentPadding: EdgeInsets.all(0.0),
          title: Container(
            padding: EdgeInsets.only(left: ScreenUtil.width * 0.08),
            child: Text(
              item.title,
              style: TextStyle(
                fontSize: item.titleSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          trailing: Container(
            child: item.trailing != null ? item.trailing : SizedBox(width: 10.0,),
            padding: EdgeInsets.only(right: ScreenUtil.width * 0.08),
          ),
          onTap: () {
            if (item.route.trim() != "")
              return print("hi");
            else
              return null;
          },
        ));
  }
}

class AlertItem {
  final String title;
  final double titleSize;
  final bool switchValue; // blocState의 boolean 값
  final bool isSwitch;
  final Icon trailing;
  final String route;
  // final BlocEvent blocEvent; //blocEvent 넣으면 좋을듯
  AlertItem(
      {this.title,
      this.titleSize,
      this.switchValue,
      this.isSwitch,
      this.trailing,
      this.route
      // this.blocEvent
      });

  static List<AlertItem> items() {
    var box = new List<AlertItem>();
    box.add(new AlertItem(
      title: "친구신청 알림",
      titleSize: 19.0,
      switchValue: true,
      isSwitch: true,
      // blocEvent:/
    ));
    box.add(new AlertItem(
      title: "메세지 알림",
      titleSize: 19.0,
      switchValue: false,
      isSwitch: true,
      // blocEvent: :
    ));
    box.add(new AlertItem(
      title: "소리",
      titleSize: 19.0,
      switchValue: true,
      isSwitch: true,
      // blocEvent:
    ));
    box.add(new AlertItem(
        title: "진동",
        titleSize: 19.0,
        switchValue: true,
        isSwitch: false,
        trailing: Icon(Icons.keyboard_arrow_right),
        route: "."
        // blocEvent:
        ));
    box.add(new AlertItem(
      title: "실험",
      titleSize: 19.0,
      isSwitch: false,
      trailing: null,
      route: "",
    ));
    return box;
  }
}
