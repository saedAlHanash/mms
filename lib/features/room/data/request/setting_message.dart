import '../../../../core/strings/enum_manager.dart';

class SettingMessage {
  SettingMessage({
    required this.identity,
    required this.name,
    required this.action,
  });

  final String identity;
  final String name;
  final ManagerActions action;

  factory SettingMessage.fromJson(Map<String, dynamic> json) {
    return SettingMessage(
      identity: json['identity'] ?? '',
      name: json['name'] ?? '',
      action: ManagerActions.values[json['action'] ?? 0],
    );
  }

  Map<String, dynamic> toJson() => {
        'identity': identity,
        'name': name,
        'action': action.index,
      };
}
