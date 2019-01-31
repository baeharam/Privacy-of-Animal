import 'package:flutter/material.dart';
import 'package:privacy_of_animal/models/user_model.dart';

class UserStateProvider extends StatefulWidget {
  final Widget child;
  final User user;

  UserStateProvider({
    this.child,
    this.user
  });

  static UserStateProviderState of(BuildContext context){
    return (context.ancestorInheritedElementForWidgetOfExactType(InheritedUserStateProvider).widget
      as InheritedUserStateProvider).userStateProviderState;
  }


  @override
  UserStateProviderState createState() => UserStateProviderState();
}

class UserStateProviderState extends State<UserStateProvider> {
  @override
  Widget build(BuildContext context) {
    return InheritedUserStateProvider(
      child: widget.child,
      userStateProviderState: this,
    );
  }
}

class InheritedUserStateProvider extends InheritedWidget {
  final UserStateProviderState userStateProviderState;
  InheritedUserStateProvider({
    Key key,
    @required this.userStateProviderState,
    @required Widget child
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}