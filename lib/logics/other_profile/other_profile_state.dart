
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class OtherProfileState extends BlocState {
  final bool isInitial;

  final bool isAlreadyFriends;
  final bool isAlreadyRequest;

  final bool isRequestLoading;
  final bool isRequestSucceeded;
  final bool isRequestFailed;

  final bool isCancelLoading;
  final bool isCancelSucceeded;
  final bool isCancelFailed;

  OtherProfileState({
    this.isInitial: false,

    this.isAlreadyFriends: false,
    this.isAlreadyRequest: false,

    this.isRequestLoading: false,
    this.isRequestSucceeded: false,
    this.isRequestFailed: false,

    this.isCancelLoading: false,
    this.isCancelSucceeded: false,
    this.isCancelFailed: false
  });

  factory OtherProfileState.initial() => OtherProfileState(isInitial: true);

  factory OtherProfileState.alreadyFriends() => OtherProfileState(isAlreadyFriends: true);
  factory OtherProfileState.alreadyRequest() => OtherProfileState(isAlreadyRequest: true);

  factory OtherProfileState.requestLoading() => OtherProfileState(isRequestLoading: true);
  factory OtherProfileState.requestSucceeded() => OtherProfileState(isRequestSucceeded: true);
  factory OtherProfileState.requestFailed() => OtherProfileState(isRequestFailed: true);

  factory OtherProfileState.cancelLoading() => OtherProfileState(isCancelLoading: true);
  factory OtherProfileState.cancelSucceeded() => OtherProfileState(isCancelSucceeded: true);
  factory OtherProfileState.cancelFailed() => OtherProfileState(isCancelFailed: true);
}