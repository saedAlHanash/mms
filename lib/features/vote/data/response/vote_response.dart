import '../../../members/data/response/member_response.dart';

class Votes {
  Votes({
    required this.items,
  });

  final List<Vote> items;

  factory Votes.fromJson(Map<String, dynamic> json) {
    return Votes(
      items: json["items"] == null
          ? []
          : List<Vote>.from(json["items"]!.map((x) => Vote.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "items": items.map((x) => x.toJson()).toList(),
      };
}

class Vote {
  Vote({
    required this.id,
    required this.pollId,
    required this.pollOption,
    required this.party,
    required this.date,
  });

  final String id;
  final String pollId;
  final PollOption pollOption;
  final Party party;
  final DateTime? date;

  factory Vote.fromJson(Map<String, dynamic> json) {
    return Vote(
      id: json["id"] ?? "",
      pollId: json["pollId"] ?? "",
      pollOption: PollOption.fromJson(json["pollOption"] ?? {}),
      party: Party.fromJson(json["party"] ?? {}),
      date: DateTime.tryParse(json["date"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "pollId": pollId,
        "pollOption": pollOption.toJson(),
        "party": party.toJson(),
        "date": date?.toIso8601String(),
      };
}

class PollOption {
  PollOption({
    required this.id,
    required this.option,
    required this.voters,
  });

  final String id;
  final String option;
  final List<Voter> voters;

  factory PollOption.fromJson(Map<String, dynamic> json) {
    return PollOption(
      id: json["id"] ?? "",
      option: json["option"] ?? "",
      voters: json["voters"] == null
          ? []
          : List<Voter>.from(json["voters"]!.map((x) => Voter.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "option": option,
        "voters": voters.map((x) => x.toJson()).toList(),
      };
}

class Voter {
  Voter({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory Voter.fromJson(Map<String, dynamic> json) {
    return Voter(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
