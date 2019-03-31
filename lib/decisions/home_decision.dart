import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state_builder.dart';
import 'package:privacy_of_animal/logics/home/home.dart';
import 'package:privacy_of_animal/logics/notification_helper.dart';
import 'package:privacy_of_animal/resources/constants.dart';
import 'package:privacy_of_animal/screens/main/screen.dart';
import 'package:privacy_of_animal/utils/back_button_dialog.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:privacy_of_animal/widgets/progress_indicator.dart';

class HomeDecision extends StatefulWidget {
  @override
  _HomeDecisionState createState() => _HomeDecisionState();
}

class _HomeDecisionState extends State<HomeDecision> {

  final HomeBloc _homeBloc = sl.get<HomeBloc>();
  final List<Widget> _homePage = [MatchScreen(),ChatListScreen(),FriendsScreen(),ProfileScreen()];

  @override
  void initState() {
    super.initState();
    sl.get<NotificationHelper>().initializeNotification(context);
    _homeBloc.emitEvent(HomeEventFetchAll());
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder(
      bloc: _homeBloc,
      builder: (context, HomeState state){
        if(state.isDataFetchFailed) {
          return Center(child: Text('데이터 로딩에 실패했습니다.'));
        }
        if(state.isDataFetchLoading) {
          return Container(
            color: Colors.white,
            alignment: Alignment.center,
            child: CircularProgressIndicator()
          );
        }

        return WillPopScope(
          onWillPop: () => BackButtonAction.terminateApp(context),
          child: Scaffold(
            body: _homePage[state.activeIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.activeIndex,
              onTap: (index) => _homeBloc.emitEvent(HomeEventNavigate(index: index)),
              items: [
                BottomNavigationBarItem(
                  title: Text(''),
                  icon: ImageIcon(
                    AssetImage('assets/images/components/match.png'),
                    size: ScreenUtil.width/4,
                  )
                ),
                BottomNavigationBarItem(
                  title: Text(''),
                  icon: ImageIcon(
                    AssetImage('assets/images/components/chat.png'),
                    size: ScreenUtil.width/4,
                  )
                ),
                BottomNavigationBarItem(
                  title: Text(''),
                  icon: ImageIcon(
                    AssetImage('assets/images/components/friend.png'),
                    size: ScreenUtil.width/4,
                  )
                ),
                BottomNavigationBarItem(
                  title: Text(''),
                  icon: ImageIcon(
                    AssetImage('assets/images/components/profile.png'),
                    size: ScreenUtil.width/4,
                  )
                )
              ],
              fixedColor: Colors.red,
              type: BottomNavigationBarType.fixed,
            ),
          ),
        );
      }
    );
  }
}