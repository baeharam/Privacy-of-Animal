import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state_builder.dart';
import 'package:privacy_of_animal/logics/home/home.dart';
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

  final HomeBloc homeBloc = sl.get<HomeBloc>();
  final List<Widget> homePage = [MatchScreen(),ChatListScreen(),FriendsScreen(),ProfileScreen()];

  @override
  void initState() {
    super.initState();
    homeBloc.emitEvent(HomeEvent(index: 3));
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder(
      bloc: homeBloc,
      builder: (context, HomeState state){
        return WillPopScope(
          onWillPop: () => BackButtonAction.terminateApp(context),
          child: Scaffold(
            body: state.isLoading ? CustomProgressIndicator() : homePage[state.activeIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.activeIndex,
              onTap: (index) => homeBloc.emitEvent(HomeEvent(index: index)),
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