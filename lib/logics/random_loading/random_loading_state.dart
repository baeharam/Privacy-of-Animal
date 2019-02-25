import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

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
  final DocumentSnapshot receiver;

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
  factory RandomLoadingState.initial() {
    return RandomLoadingState(
      isInitial: true
    );
  }

  /// 채팅방 ID 받아오기 [실패]
  factory RandomLoadingState.getRoomIDFailed() {
    return RandomLoadingState(
      isGetRoomIDFailed: true
    );
  }

  /// 상대방 데이터 받아오기 [실패]
  factory RandomLoadingState.receiverDataFetchFailed() {
    return RandomLoadingState(
      isReceiverDataFetchFailed: true
    );
  }

  /// 채팅방 만들기 [성공]
  factory RandomLoadingState.chatRoomMadeSucceeded({@required chatRoomID}) {
    return RandomLoadingState(
      isChatRoomMadeSucceeded: true,
      chatRoomID: chatRoomID
    );
  }

  /// 채팅방 만들기 [실패]
  factory RandomLoadingState.chatRoomMadeFailed() {
    return RandomLoadingState(
      isChatRoomMadeFailed: true
    );
  }

  /// 매칭 [로딩]
  factory RandomLoadingState.matchLoading() {
    return RandomLoadingState(
      isMatchLoading: true
    );
  }

  /// 매칭 [성공]
  factory RandomLoadingState.matchSucceeded({@required chatRoomID, @required receiver}) {
    return RandomLoadingState(
      isMatchSucceeded: true,
      chatRoomID: chatRoomID,
      receiver: receiver
    );
  }

  /// 매칭 [실패]
  factory RandomLoadingState.matchFailed() {
    return RandomLoadingState(
      isMatchFailed: true
    );
  }

  /// 취소 [성공]
  factory RandomLoadingState.cancelSucceeded() {
    return RandomLoadingState(
      isCancelSucceeded: true
    );
  }

  /// 취소 [실패]
  factory RandomLoadingState.cancelFailed() {
    return RandomLoadingState(
      isCancelFailed: true
    );
  }
}