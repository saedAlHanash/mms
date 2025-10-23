import '../../../../core/strings/enum_manager.dart';

class SettingMessage {
  SettingMessage({
    required this.sid,
    required this.name,
    required this.action,
  });

  final String sid;
  final String name;
  final ManagerActions action;

  factory SettingMessage.fromJson(Map<String, dynamic> json) {
    return SettingMessage(
      sid: json['sid'] ?? '',
      name: json['name'] ?? '',
      action: ManagerActions.values[json['action'] ?? 0],
    );
  }

  Map<String, dynamic> toJson() => {
        'sid': sid,
        'name': name,
        'action': action.index,
      };
}
