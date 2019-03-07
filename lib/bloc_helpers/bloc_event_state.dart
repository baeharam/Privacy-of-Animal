import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

abstract class BlocEvent extends Object {}
abstract class BlocState extends Object {}

abstract class BlocBase { void dispose(); }

abstract class BlocEventStateBase<BlocEvent, BlocState> implements BlocBase {
  PublishSubject<BlocEvent> _eventController = PublishSubject<BlocEvent>();
  BehaviorSubject<BlocState> _stateController = BehaviorSubject<BlocState>();

  // 이벤트를 발생시키는 함수
  Function(BlocEvent) get emitEvent => _eventController.sink.add;
  // 현재/새로운 상태
  Stream<BlocState> get state => _stateController.stream;
  // 이벤트에 따른 외부 작업 핸들링
  Stream<BlocState> eventHandler(BlocEvent event, BlocState currentState);

  final BlocState initialState;

  BlocEventStateBase({
    @required this.initialState
  }){
    _eventController.listen((BlocEvent event){
      BlocState currentState = _stateController.value ?? initialState;
      eventHandler(event,currentState).forEach((BlocState newState){
        _stateController.sink.add(newState);
      });
    });
  }

  @override
  void dispose(){
    _eventController.close();
    _stateController.close();
  }
}