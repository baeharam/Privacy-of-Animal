import 'package:flutter/material.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_provider.dart';

class MultipleBlocProvider extends StatefulWidget {
  MultipleBlocProvider({Key key, @required this.child, @required this.blocs})
      : super(key: key);

  final Widget child;
  final List<BlocBase> blocs;

  _MultipleBlocProviderState createState() => _MultipleBlocProviderState();

  static T of<T extends BlocBase>(BuildContext context) {
    _InheritedBlocProvider provider = context
        .ancestorInheritedElementForWidgetOfExactType(_InheritedBlocProvider)
        .widget;
    return provider.blocs.lastWhere((bloc) => bloc is T);
  }
}

class _MultipleBlocProviderState extends State<MultipleBlocProvider> {
  @override
  Widget build(BuildContext context) => _InheritedBlocProvider(
      blocs: widget.blocs,
      child: widget.child,
    );

  @override
  void dispose() {
    widget.blocs.map((bloc) => bloc.dispose());
    super.dispose();
  }
}

class _InheritedBlocProvider extends InheritedWidget {
  _InheritedBlocProvider({Key key, this.child, this.blocs})
      : super(key: key, child: child);

  final Widget child;
  final List<BlocBase> blocs;

  @override
  bool updateShouldNotify(_InheritedBlocProvider oldWidget) => false;
}