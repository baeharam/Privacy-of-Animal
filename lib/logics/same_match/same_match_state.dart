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

  final SameMatchModel sameMatchModel;

  SameMatchState({
    this.isInitial: false,
    this.isFindLoading: false,
    this.isFindSucceeded: false,
    this.isFindFailed: false,
    this.isRequestLoading: false,
    this.isRequestSucceeded: false,
    this.isRequestFailed: false,

    this.sameMatchModel
  });

  factory SameMatchState.initial() {
    return SameMatchState(
      isInitial: true
    );
  }

  factory SameMatchState.findLoading() {
    return SameMatchState(
      isFindLoading: true
    );
  }

  factory SameMatchState.findSucceeded(SameMatchModel sameMatchModel) {
    return SameMatchState(
      isFindSucceeded: true,
      sameMatchModel: sameMatchModel
    );
  }

  factory SameMatchState.findFailed() {
    return SameMatchState(
      isFindFailed: true
    );
  }

  factory SameMatchState.requestLoading() {
    return SameMatchState(
      isRequestLoading: true
    );
  }

  factory SameMatchState.requestSucceeded() {
    return SameMatchState(
      isRequestSucceeded: true
    );
  }

  factory SameMatchState.requestFailed() {
    return SameMatchState(
      isRequestFailed: true
    );
  }
}