
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class OtherProfileState extends BlocState {
  final bool isInitial;

  final bool isRefreshLoading;
  final bool isRefreshFriends;
  final bool isRefreshRequestFrom;
  final bool isRefreshRequestTo;

  final bool isRequestLoading;
  final bool isRequestSucceeded;
  final bool isRequestFailed;

  final bool isCancelLoading;
  final bool isCancelSucceeded;
  final bool isCancelFailed;

  OtherProfileState({
    this.isInitial: false,

    this.isRefreshLoading: false,
    this.isRefreshFriends: false,
    this.isRefreshRequestFrom: false,
    this.isRefreshRequestTo: false,

    this.isRequestLoading: false,
    this.isRequestSucceeded: false,
    this.isRequestFailed: false,

    this.isCancelLoading: false,
    this.isCancelSucceeded: false,
    this.isCancelFailed: false
  });

  factory OtherProfileState.initial() => OtherProfileState(isInitial: true);

  factory OtherProfileState.refreshLoading() => OtherProfileState(isRefreshLoading: true);
  factory OtherProfileState.refreshFriends() => OtherProfileState(isRefreshFriends: true);
  factory OtherProfileState.refreshRequestFrom() => OtherProfileState(isRefreshRequestFrom: true);
  factory OtherProfileState.refreshRequestTo() => OtherProfileState(isRefreshRequestTo: true);

  factory OtherProfileState.requestLoading() => OtherProfileState(isRequestLoading: true);
  factory OtherProfileState.requestSucceeded() => OtherProfileState(isRequestSucceeded: true);
  factory OtherProfileState.requestFailed() => OtherProfileState(isRequestFailed: true);

  factory OtherProfileState.cancelLoading() => OtherProfileState(isCancelLoading: true);
  factory OtherProfileState.cancelSucceeded() => OtherProfileState(isCancelSucceeded: true);
  factory OtherProfileState.cancelFailed() => OtherProfileState(isCancelFailed: true);
}