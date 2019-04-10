import 'package:meta/meta.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/models/user_model.dart';

class RandomLoadingState extends BlocState {
  
  final bool isInitial;

  final bool isChatRoomMadeSucceeded;
  final bool isChatRoomMadeFailed;

  final bool isMatchLoading;
  final bool isMatchSucceeded;
  final bool isMatchFailed;

  final bool isCancelSucceeded;
  final bool isCancelFailed;

  final bool isGetRoomIDFailed;
  final bool isReceiverDataFetchFailed;

  final String chatRoomID;
  final UserModel receiver;

  RandomLoadingState({
    this.isInitial: false,

    this.isChatRoomMadeSucceeded: false,
    this.isChatRoomMadeFailed: false,

    this.isMatchLoading: false,
    this.isMatchSucceeded: false,
    this.isMatchFailed: false,

    this.isCancelSucceeded: false,
    this.isCancelFailed: false,

    this.isGetRoomIDFailed: false,
    this.isReceiverDataFetchFailed: false,

    this.chatRoomID: '',
    this.receiver
  });

  // 초기상태
  factory RandomLoadingState.initial() => RandomLoadingState(isInitial: true);

  /// 채팅방 ID 받아오기 [실패]
  factory RandomLoadingState.getRoomIDFailed() => RandomLoadingState(isGetRoomIDFailed: true);

  /// 상대방 데이터 받아오기 [실패]
  factory RandomLoadingState.receiverDataFetchFailed() => RandomLoadingState(isReceiverDataFetchFailed: true);

  /// 채팅방 만들기 [성공]
  factory RandomLoadingState.chatRoomMadeSucceeded({@required chatRoomID}) {
    return RandomLoadingState(
      isChatRoomMadeSucceeded: true,
      chatRoomID: chatRoomID
    );
  }

  /// 채팅방 만들기 [실패]
  factory RandomLoadingState.chatRoomMadeFailed() => RandomLoadingState(isChatRoomMadeFailed: true);

  /// 매칭 [로딩]
  factory RandomLoadingState.matchLoading() => RandomLoadingState(isMatchLoading: true);
  /// 매칭 [성공]
  factory RandomLoadingState.matchSucceeded({@required chatRoomID, @required receiver}) {
    return RandomLoadingState(
      isMatchSucceeded: true,
      chatRoomID: chatRoomID,
      receiver: receiver
    );
  }
  /// 매칭 [실패]
  factory RandomLoadingState.matchFailed() => RandomLoadingState(isMatchFailed: true);

  /// 취소 [성공]
  factory RandomLoadingState.cancelSucceeded() => RandomLoadingState(isCancelSucceeded: true);
  /// 취소 [실패]
  factory RandomLoadingState.cancelFailed() => RandomLoadingState(isCancelFailed: true);
}