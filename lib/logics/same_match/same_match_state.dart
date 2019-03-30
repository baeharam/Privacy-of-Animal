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

  final bool isAlreadyFriends;
  final bool isAlreadyRequest;

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

    this.isAlreadyFriends: false,
    this.isAlreadyRequest: false,

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

  factory SameMatchState.alreadyFriends() => SameMatchState(isAlreadyFriends: true);
  factory SameMatchState.alreadyRequest() => SameMatchState(isAlreadyRequest: true);
}