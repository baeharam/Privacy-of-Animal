import 'dart:async';

import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/random_loading/random_loading.dart';
import 'package:privacy_of_animal/models/user_model.dart';

class RandomLoadingBloc extends BlocEventStateBase<RandomLoadingEvent,RandomLoadingState>
{
  static final RandomLoadingAPI _api = RandomLoadingAPI();
  String _chatRoomID = '';

  @override
  RandomLoadingState get initialState => RandomLoadingState.initial();

  @override
  Stream<RandomLoadingState> eventHandler(RandomLoadingEvent event, RandomLoadingState currentState) async*{
    
    if(event is RandomLoadingEventStateClear) {
      yield RandomLoadingState();
    }

    if(event is RandomLoadingEventMatchStart){
      _api.connectLoading();
      try {
        _chatRoomID = await _api.getRoomID();
        if(_chatRoomID.isEmpty) {
          try {
            _chatRoomID = await _api.makeChatRoom();
            yield RandomLoadingState.chatRoomMadeSucceeded(chatRoomID: _chatRoomID);
          } catch(exception) {
            print('채팅방 만들기 실패\n${exception.toString()}');
            yield RandomLoadingState.chatRoomMadeFailed();
          }
        } else {
          await _api.disconnectLoading();
          try {
            UserModel user = await _api.enterRoomAndGetUser(_chatRoomID);
            yield RandomLoadingState.matchSucceeded(
              chatRoomID: _chatRoomID,
              receiver: user
            );
          } catch(exception) {
            print('매칭 실패\n${exception.toString()}');
            yield RandomLoadingState.matchFailed();
          }
        }
      } catch(exception) {
        print('채팅방 ID 받아오기 실패\n${exception.toString()}');
        yield RandomLoadingState.getRoomIDFailed();
      }
    }

    if(event is RandomLoadingEventUserEntered) {
      await _api.disconnectLoading();
      try {
        UserModel userData = await _api.fetchUserData(event.receiver);
        yield RandomLoadingState.matchSucceeded(
          receiver: userData,
          chatRoomID: event.chatRoomID
        );
      } catch(exception) {
        print('상대방 데이터 받아오기 실패\n${exception.toString()}');
        yield RandomLoadingState.receiverDataFetchFailed();
      }
    }

    if(event is RandomLoadingEventCancel) {
      await _api.disconnectLoading();
      try {
        await _api.deleteMadeChatRoom();
        yield RandomLoadingState.cancelSucceeded();
      } catch(exception) {
        print('매칭 취소 실패\n${exception.toString()}');
        yield RandomLoadingState.cancelFailed();
      }
    }
  }
}