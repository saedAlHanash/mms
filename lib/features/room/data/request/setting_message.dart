import 'dart:convert';
import 'dart:typed_data';

import '../../../../core/strings/enum_manager.dart';

class SettingMessage {
  SettingMessage({
    this.id = '',
    this.toIdentity = '',
    required this.action,
    this.metadata,
    required this.toUserType,
  });

  final String id;

  /// If empty string means broadcast to all users
  final String toIdentity;
  final ManagerActions action;
  final LkUserType toUserType;
  final Map<String, dynamic>? metadata;

  String get name => metadata?['name'] ?? '';

  String get message => metadata?['message'] ?? '';

  String get userId => metadata?['id'] ?? '';

  factory SettingMessage.fromJson(Map<String, dynamic> json) {
    return SettingMessage(
      id: (json['id'] ?? '').toString(),
      toIdentity: json['identity'] ?? '',
      action: ManagerActions.values[json['action'] ?? 0],
      metadata: json['metadata'] ?? {},
      toUserType: LkUserType.values[json['toUserType'] ?? 0],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id.isNotEmpty ? id : DateTime.now().millisecondsSinceEpoch.toString(),
        'metadata': metadata,
        'identity': toIdentity,
        'action': action.index,
        'toUserType': toUserType.index,
      };

  Uint8List get toBytes {
    final jsonString = jsonEncode(toJson());
    return Uint8List.fromList(utf8.encode(jsonString));
  }
}
