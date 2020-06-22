import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';

import '../../api/auth.dart';
import '../../api/firestore/play_room.dart';
import '../../api/firestore/store.dart';
import '../../api/firestore/user.dart';
import 'lobby_state.dart';

class LobbyNotifier extends ValueNotifier<LobbyState> {
  LobbyNotifier(this._auth, this._store) : super(LobbyState()) {
    fetchPlayRooms(); // 非同期で初期取得
  }

  final Auth _auth;
  final Store _store;

  final _roomListLimit = 5;

  Future<void> createPublicPlayRoom() async {
    final user = await _auth.currentUser;
    final userDocRef = _store.docRef<User>(user.id);
    final room = PlayRoom(
      host: userDocRef.ref,
      title: 'はじめての人生',
      humans: [userDocRef.ref],
      // FIXME: null 禁止だからテキトーに入れてるだけで絶対に修正しないとダメ
      //        rules 側に存否チェックが無いからこれ通るけど、ホント一時的なダミー実装に過ぎない
      lifeRoad: userDocRef.ref,
      currentTurnHumanId: user.id,
    );
    final roomDocRef = _store.collectionRef<PlayRoom>().docRef();
    final batch = _store.firestore.batch();
    await roomDocRef.setData(room.encode(), batch: batch);
    await userDocRef.updateData(
      <String, dynamic>{
        UserField.joinPlayRoom: roomDocRef.ref,
        TimestampField.updatedAt: FieldValue.serverTimestamp(),
      },
      batch: batch,
    );
    await batch.commit(); // FIXME: エラーハンドリング. 特に既に join 済みの場合のハンドリング.
  }

  Future<void> fetchPlayRooms() async {
    final collectionRef = _store.collectionRef<PlayRoom>();
    value.publicPlayRooms = await collectionRef.getDocuments(
      (query) => query.limit(_roomListLimit).orderBy(TimestampField.createdAt),
    );
    notifyListeners();
  }
}
