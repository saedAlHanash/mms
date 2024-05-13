import 'package:mms/core/extensions/extensions.dart';

import '../../util/abstraction.dart';

const commandInitial = Command(pag: 1, perPage: 20);

class Command {
  const Command({
    required this.pag,
    required this.perPage,
  });

  final int pag;
  final int perPage;

  factory Command.noPagination() {
    return Command(perPage: 1.max, pag: 1);
  }

  Map<String, dynamic> toJson() {
    return {
      'page': pag,
      'perPage': perPage,
    };
  }

  factory Command.fromJson(Map<String, dynamic> map) {
    return Command(
      pag: map['pag'] ?? 1,
      perPage: map['perPage'] ?? 15,
    );
  }

  Command copyWith({
    int? pag,
    int? perPage,
    int? minimal,
  }) {
    return Command(
      pag: pag ?? this.pag,
      perPage: perPage ?? this.perPage,
    );
  }

  Command fromMeta({required AbstractMeta meta}) {
    return Command(
      pag: meta.meta.currentPage,
      perPage: meta.meta.perPage,
    );
  }
}

class Meta {
  Meta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.perPage,
    required this.to,
    required this.total,
  });

  final int currentPage;
  final int from;
  final int lastPage;
  final int perPage;
  final int to;
  final int total;

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      currentPage: json["current_page"] ?? 1,
      from: int.tryParse(json["from"].toString()) ?? 0,
      lastPage: json["last_page"] ?? 1,
      perPage: json["per_page"] ?? 20,
      to: json["to"] ?? 1,
      total: json["total"] ?? 20,
    );
  }

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "last_page": lastPage,
        "per_page": perPage,
        "to": to,
        "total": total,
      };
}
