import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class FindPasswordState extends BlocState {
  final bool isEmailSendSucceeded;
  final bool isEmailSendFailed;
  final bool isEmailSending;

  FindPasswordState({
    this.isEmailSendSucceeded: false,
    this.isEmailSendFailed: false,
    this.isEmailSending: false
  });

  factory FindPasswordState.initial() {
    return FindPasswordState(
      isEmailSendSucceeded: false,
      isEmailSendFailed: false,
      isEmailSending: false
    );
  }

  factory FindPasswordState.succeeded() {
    return FindPasswordState(
      isEmailSendSucceeded: true,
      isEmailSendFailed: false,
      isEmailSending: false
    );
  }

  factory FindPasswordState.loading() {
    return FindPasswordState(
      isEmailSendSucceeded: false,
      isEmailSendFailed: false,
      isEmailSending: true
    );
  }

  factory FindPasswordState.failed() {
    return FindPasswordState(
      isEmailSendSucceeded: false,
      isEmailSendFailed: true,
      isEmailSending: false
    );
  }
}