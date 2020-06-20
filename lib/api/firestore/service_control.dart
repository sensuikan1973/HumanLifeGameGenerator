import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'firestore.dart';

part 'service_control.freezed.dart';
part 'service_control.g.dart';

/// Document on Firestore
@freezed
abstract class ServiceControl with _$ServiceControl {
  const factory ServiceControl({
    @required bool isMaintenance,
    @required String requiredMinVersion,
    @required @TimestampConverter() DateTime createdAt,
    @required @TimestampConverter() DateTime updatedAt,
  }) = _ServiceControl;
  factory ServiceControl.fromJson(Map<String, dynamic> json) => _$ServiceControlFromJson(json);

  @visibleForTesting
  static const collectionId = 'serviceControl';
}

class ServiceControlsRef extends CollectionRef<ServiceControl, Document<ServiceControl>> {
  ServiceControlsRef(Store store)
      : super(
          store.firestore.collection(ServiceControl.collectionId),
          decoder: (snapshot) => Document(snapshot.reference, ServiceControl.fromJson(snapshot.data)),
          encoder: (serviceControl) => replacingTimestamp(
            json: serviceControl.toJson(),
          ),
        );
}

class ServiceControlField {
  /// メンテナス中かどうか
  static const isMaintenance = 'isMaintenance';

  /// 求める最低バージョン
  static const requiredMinVersion = 'requiredMinVersion';
}

/// 特定の Document を Id で参照する用
class ServiceControlDocId {
  /// Web application
  static const web = 'web';
}