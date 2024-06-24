import 'package:collection/collection.dart';
import 'package:mms/core/app/app_provider.dart';

import '../../../../core/strings/enum_manager.dart';
import '../../../../core/widgets/spinner_widget.dart';

class Polls {
  Polls({
    required this.items,
  });

  final List<Poll> items;

  factory Polls.fromJson(Map<String, dynamic> json) {
    return Polls(
      items: json["items"] == null
          ? []
          : List<Poll>.from(json["items"]!.map((x) => Poll.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "items": items.map((x) => x.toJson()).toList(),
      };
}

class Poll {
  Poll({
    required this.id,
    required this.meetingId,
    required this.topic,
    required this.date,
    required this.status,
    required this.isResultPublished,
    required this.options,
  });

  final String id;
  final String meetingId;
  final String topic;
  final DateTime? date;
  final PollStatus status;
  final bool isResultPublished;
  final List<Option> options;



  factory Poll.fromJson(Map<String, dynamic> json) {
    return Poll(
      id: json["id"] ?? "",
      meetingId: json["meetingId"] ?? "",
      topic: json["topic"] ?? "",
      date: DateTime.tryParse(json["date"] ?? ""),
      status: PollStatus.values[json["status"] ?? 0],
      isResultPublished: json["isResultPublished"] ?? false,
      options: json["options"] == null
          ? []
          : List<Option>.from(json["options"]!.map((x) => Option.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "meetingId": meetingId,
        "topic": topic,
        "date": date?.toIso8601String(),
        "status": status.index,
        "isResultPublished": isResultPublished,
        "options": options.map((x) => x.toJson()).toList(),
      };
}

class PollResult {
  PollResult({
    required this.id,
    required this.topic,
    required this.isResultPublished,
    required this.totalVotes,
    required this.voteResults,
  });

  final String id;
  final String topic;
  final bool isResultPublished;
  final num totalVotes;
  final List<VoteResult> voteResults;

  factory PollResult.fromJson(Map<String, dynamic> json) {
    return PollResult(
      id: json["id"] ?? "",
      topic: json["topic"] ?? "",
      isResultPublished: json["isResultPublished"] ?? false,
      totalVotes: json["totalVotes"] ?? 0,
      voteResults: json["voteResults"] == null
          ? []
          : List<VoteResult>.from(
              json["voteResults"]!.map((x) => VoteResult.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "topic": topic,
        "isResultPublished": isResultPublished,
        "totalVotes": totalVotes,
        "voteResults": voteResults.map((x) => x.toJson()).toList(),
      };
}

class VoteResult {
  VoteResult({
    required this.optionId,
    required this.option,
    required this.voteCount,
  });

  final String optionId;
  final String option;
  final num voteCount;

  factory VoteResult.fromJson(Map<String, dynamic> json) {
    return VoteResult(
      optionId: json["optionId"] ?? "",
      option: json["option"] ?? "",
      voteCount: json["voteCount"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "optionId": optionId,
        "option": option,
        "voteCount": voteCount,
      };
}

class Option {
  Option({
    required this.id,
    required this.option,
    required this.voters,
  });

  final String id;
  final String option;
  final List<Voter> voters;


  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
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
    required this.partyId,
  });

  final String id;
  final String name;
  final String partyId;

  factory Voter.fromJson(Map<String, dynamic> json) {
    return Voter(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      partyId: json["partyId"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "partyId": partyId,
      };
}
