import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/models/same_match_model.dart';

class SameMatchState extends BlocState {
  final bool isInitial;
  final bool isLoading;
  final bool isFindSucceeded;
  final bool isFindFailed;

  final SameMatchModel sameMatchModel;

  SameMatchState({
    this.isInitial: false,
    this.isLoading: false,
    this.isFindSucceeded: false,
    this.isFindFailed: false,

    this.sameMatchModel
  });

  factory SameMatchState.initial() {
    return SameMatchState(
      isInitial: true
    );
  }

  factory SameMatchState.loading() {
    return SameMatchState(
      isLoading: true
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
}