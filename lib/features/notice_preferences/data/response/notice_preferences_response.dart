/// `NoticePreferencesDto`: the signed-in person's notification settings.
class NoticePreferences {
  NoticePreferences({required this.language, required this.groups});

  /// "ar" or "en"; null keeps the current one on update.
  final String? language;

  /// Meetings, Minutes, Tasks and Mentions.
  final List<NoticeGroup> groups;

  /// Push is on when it's on for every group (or nothing was loaded yet).
  bool get allPush => groups.every((e) => e.push);

  NoticePreferences withPush(bool push) => NoticePreferences(
        language: language,
        groups: groups.map((e) => e.copyWith(push: push)).toList(),
      );

  factory NoticePreferences.fromJson(Map<String, dynamic> json) {
    return NoticePreferences(
      language: json['language'],
      groups: (json['groups'] as List? ?? []).map((e) => NoticeGroup.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'language': language,
        'groups': groups.map((e) => e.toJson()).toList(),
      };
}

class NoticeGroup {
  NoticeGroup({required this.group, required this.push, required this.email, required this.sms});

  final String group;
  final bool push;
  final bool email;
  final bool sms;

  NoticeGroup copyWith({bool? push}) => NoticeGroup(group: group, push: push ?? this.push, email: email, sms: sms);

  factory NoticeGroup.fromJson(Map<String, dynamic> json) {
    return NoticeGroup(
      group: json['group'] ?? '',
      push: json['push'] ?? true,
      email: json['email'] ?? true,
      sms: json['sms'] ?? true,
    );
  }

  Map<String, dynamic> toJson() => {'group': group, 'push': push, 'email': email, 'sms': sms};
}
