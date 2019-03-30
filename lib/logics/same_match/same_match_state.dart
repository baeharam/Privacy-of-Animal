import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/models/same_match_model.dart';

class SameMatchState extends BlocState {
  final bool isInitial;
  final bool isFindLoading;
  final bool isFindSucceeded;
  final bool isFindFailed;

  final bool isRequestLoading;
  final bool isRequestSucceeded;
  final bool isRequestFailed;

  final bool isCancelLoading;
  final bool isCancelSucceeded;
  final bool isCancelFailed;

  final bool isRefreshLoading;
  final bool isRefreshFriends;
  final bool isRefreshRequestFrom;
  final bool isRefreshRequestTo;

  final SameMatchModel sameMatchModel;

  SameMatchState({
    this.isInitial: false,
    this.isFindLoading: false,
    this.isFindSucceeded: false,
    this.isFindFailed: false,
    this.isRequestLoading: false,
    this.isRequestSucceeded: false,
    this.isRequestFailed: false,
    this.isCancelLoading: false,
    this.isCancelSucceeded: false,
    this.isCancelFailed: false,

    this.isRefreshLoading: false,
    this.isRefreshFriends: false,
    this.isRefreshRequestFrom: false,
    this.isRefreshRequestTo: false,

    this.sameMatchModel
  });

  factory SameMatchState.initial() => SameMatchState(isInitial: true);

  factory SameMatchState.findLoading() => SameMatchState(isFindLoading: true);
  factory SameMatchState.findSucceeded(SameMatchModel sameMatchModel) {
    return SameMatchState(
      isFindSucceeded: true,
      sameMatchModel: sameMatchModel
    );
  }
  factory SameMatchState.findFailed() => SameMatchState(isFindFailed: true);

  factory SameMatchState.requestLoading() => SameMatchState(isRequestLoading: true);
  factory SameMatchState.requestSucceeded() => SameMatchState(isRequestSucceeded: true);
  factory SameMatchState.requestFailed() => SameMatchState(isRequestFailed: true);

  factory SameMatchState.cancelLoading() => SameMatchState(isCancelLoading: true);
  factory SameMatchState.cancelSucceeded() => SameMatchState(isCancelSucceeded: true);
  factory SameMatchState.cancelFailed() => SameMatchState(isCancelFailed: true);

  factory SameMatchState.refreshLoading() => SameMatchState(isRequestLoading: true);
  factory SameMatchState.refreshFriends() => SameMatchState(isRefreshFriends: true);
  factory SameMatchState.refreshRequestFrom() => SameMatchState(isRefreshRequestFrom: true);
  factory SameMatchState.refreshRequestTo() => SameMatchState(isRefreshRequestTo: true);
}