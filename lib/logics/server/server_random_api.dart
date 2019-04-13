
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/firebase_api.dart';
import 'package:privacy_of_animal/logics/random_chat/random_chat.dart';
import 'package:privacy_of_animal/logics/random_loading/random_loading.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';
import 'package:rxdart/rxdart.dart';

class ServerRandomAPI {

  Observable<QuerySnapshot> _randomLoadingServer, _randomChatServer,_randomChatOutServer;
  StreamSubscription<QuerySnapshot> _randomLoadingSubscription, _randomChatSubscription,_randomChatOutSubscription;

  ServerRandomAPI() {
    _randomChatServer =
    _randomChatOutServer =
    _randomLoadingServer = Observable(Stream.empty());

    _randomChatSubscription = 
    _randomChatOutSubscription = 
    _randomLoadingSubscription = _randomChatOutServer.listen((_){});
  }

  /// [랜덤 매칭, 채팅방 만들고 기다리는 연결 ]
  void connectRandomLoading() {
    debugPrint('랜덤 매칭, 채팅방 만들고 기다리는 연결');

    Stream<QuerySnapshot> snapshot = sl.get<FirebaseAPI>().getFirestore()
        .collection(firestoreRandomMessageCollection)
        .where(firestoreChatBeginField,isEqualTo: true)
        .where('$firestoreChatUsersField.${sl.get<CurrentUser>().uid}',isEqualTo: true)
        .snapshots();

    _randomLoadingServer = Observable(snapshot);

    _randomLoadingSubscription = _randomLoadingServer.listen((snapshot){
      if(snapshot.documents.isNotEmpty){
        debugPrint('상대방 들어옴!');

        String receiver = '';
        (snapshot.documents[0].data[firestoreChatUsersField] as Map).forEach((key,value){
          if(key!=sl.get<CurrentUser>().uid){
            receiver = key;
          }
        });
        sl.get<RandomLoadingBloc>().emitEvent(RandomLoadingEventUserEntered(
          receiver: receiver,
          chatRoomID: snapshot.documents[0].documentID
        ));
      }
    });
  }

  /// [랜덤 매칭, 채팅방 만들고 기다리는 연결 해제]
  Future<void> disconnectRandomLoading() async {
    debugPrint('랜덤 매칭, 채팅방 만들고 기다리는 연결 해제');

    await _randomLoadingSubscription.cancel();
  }

  /// [랜덤 매칭 성공할시 연결]
  void connectRandomChat(String chatRoomID) {
    debugPrint('랜덤채팅 연결');

    _randomChatServer = Observable(
      sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreRandomMessageCollection)
      .document(chatRoomID)
      .collection(chatRoomID)
      .orderBy(firestoreChatTimestampField,descending: true)
      .snapshots()
    );
    
    _randomChatSubscription = _randomChatServer.listen((chatData){
      if(chatData.documentChanges.isNotEmpty) {
        sl.get<RandomChatBloc>().emitEvent(RandomChatEventMessageReceived(
          chatSnapshot: chatData
        ));
      }
    });
  }

  /// [랜덤매칭에서 나갈시 연결 해제]
  Future<void> disconnectRandomChat() async {
    debugPrint('랜덤채팅 연결 해제');

    await _randomChatSubscription.cancel();
  }

  /// [랜덤채팅에서 나가는지 확인하는 연결]
  void connectRandomChatOut(String otherUserUID) {
    debugPrint('랜덤채팅에서 나가는지 확인하는 연결');

    _randomChatOutServer = Observable(
      sl.get<FirebaseAPI>().getFirestore()
      .collection(firestoreRandomMessageCollection)
      .where('$firestoreChatUsersField.$otherUserUID',isEqualTo: true)
      .where('$firestoreChatUsersField.${sl.get<CurrentUser>().uid}',isEqualTo: true)
      .where(firestoreChatOutField,isEqualTo: true)
      .snapshots()
    );
    
    _randomChatOutSubscription = _randomChatOutServer.listen((snapshot){
      if(snapshot.documents.isNotEmpty) {
        sl.get<RandomChatBloc>().emitEvent(RandomChatEventFinished());
      }
    });
  }

  /// [랜덤채팅에서 나가는지 확인하는 연결 해제]
  Future<void> disconnectRandomChatOut() async {
    debugPrint('랜덤채팅에서 나가는지 확인하는 연결 해제');

    await _randomChatOutSubscription.cancel();
  }
}