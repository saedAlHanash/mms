import 'package:collection/collection.dart';
import 'package:mms/core/extensions/extensions.dart';

import 'package:mms/core/app/app_provider.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/generated/assets.dart';
import 'package:mms/features/agendas/data/response/agendas_response.dart';
import 'package:mms/features/attendees/data/response/attendee_response.dart';
import 'package:mms/features/members/data/response/member_response.dart';
import 'package:mms/features/poll/data/response/poll_response.dart';

class MeetingsResponse {
  MeetingsResponse({
    required this.items,
  });

  final List<Meeting> items;

  factory MeetingsResponse.fromJson(Map<String, dynamic> json) {
    return MeetingsResponse(
      items: json["items"] == null ? [] : List<Meeting>.from(json["items"]!.map((x) => Meeting.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "items": items.map((x) => x.toJson()).toList(),
      };
}

class Meeting {
  Meeting({
    required this.id,
    required this.title,
    required this.meetingPlace,
    required this.hasRequestAbsence,
    required this.fromDate,
    required this.toDate,
    required this.scheduledDate,
    required this.status,
    required this.committeeId,
    required this.committeeName,
    required this.attendeesList,
    required this.guestsList,
    required this.discussions,
    required this.documents,
    required this.agendaItems,
    required this.location,
    required this.onlineMeetingUrl,
    required this.onlineMeetingToken,
    required this.attendeeOnlineToken,
    required this.absenceRequests,
    required this.guestSuggestions,
    required this.decisions,
    required this.polls,
    required this.tasks,
    required this.minutes,
    required this.pollResults,
    required this.mode,
    required this.hijriDate,
    required this.callerMembershipType,
  });

  final String id;
  final String title;
  final String meetingPlace;
  final bool hasRequestAbsence;
  final DateTime? fromDate;
  final DateTime? toDate;
  final DateTime? scheduledDate;
  final MeetingStatus status;
  final String committeeId;
  final String committeeName;
  final List<Attendee> attendeesList;
  final List<Guest> guestsList;
  final List<Discussion> discussions;
  final List<Document> documents;
  final List<Agenda> agendaItems;
  final Location location;
  final String onlineMeetingUrl;
  final String onlineMeetingToken;
  final String attendeeOnlineToken;
  final List<AbsenceRequest> absenceRequests;
  final List<Guest> guestSuggestions;
  final List<Decision> decisions;
  final List<Poll> polls;
  final List<Task> tasks;
  final Minutes minutes;
  final List<PollResult> pollResults;

  /// In person / online / hybrid; null when the meeting has none.
  final MeetingMode? mode;

  /// Umm al-Qura date (`dd/MM/yyyy`), empty without a date.
  final String hijriDate;

  /// The signed-in person's role in this meeting's committee (a delegated role
  /// included); an outside invitee gets [MembershipType.member]; null when none.
  final MembershipType? callerMembershipType;

  /// Copy used to apply live (SignalR) updates without a refetch.
  Meeting copyWith({
    List<Discussion>? discussions,
    List<Decision>? decisions,
    List<Poll>? polls,
    List<PollResult>? pollResults,
  }) {
    return Meeting(
      id: id,
      title: title,
      meetingPlace: meetingPlace,
      hasRequestAbsence: hasRequestAbsence,
      fromDate: fromDate,
      toDate: toDate,
      scheduledDate: scheduledDate,
      status: status,
      committeeId: committeeId,
      committeeName: committeeName,
      attendeesList: attendeesList,
      guestsList: guestsList,
      discussions: discussions ?? this.discussions,
      documents: documents,
      agendaItems: agendaItems,
      location: location,
      onlineMeetingUrl: onlineMeetingUrl,
      onlineMeetingToken: onlineMeetingToken,
      attendeeOnlineToken: attendeeOnlineToken,
      absenceRequests: absenceRequests,
      guestSuggestions: guestSuggestions,
      decisions: decisions ?? this.decisions,
      polls: polls ?? this.polls,
      tasks: tasks,
      minutes: minutes,
      pollResults: pollResults ?? this.pollResults,
      mode: mode,
      hijriDate: hijriDate,
      callerMembershipType: callerMembershipType,
    );
  }

  factory Meeting.fromJson(Map<String, dynamic> json) {
    return Meeting(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      meetingPlace: json["meetingPlace"] ?? "",
      fromDate: DateTime.tryParse(json["fromDate"] ?? ""),
      toDate: DateTime.tryParse(json["toDate"] ?? ""),
      scheduledDate: DateTime.tryParse(json["scheduledDate"] ?? ""),
      status: MeetingStatus.values[json["status"] ?? 0],
      committeeId: json["committeeId"] ?? "",
      committeeName: json["committeeName"] ?? "",
      hasRequestAbsence: json["hasRequestAbsence"] ?? false,
      attendeesList: json["attendeesList"] == null
          ? <Attendee>[]
          : List<Attendee>.from(json["attendeesList"]!.map((x) => Attendee.fromJson(x))),
      guestsList: json["guestsList"] == null ? [] : List<Guest>.from(json["guestsList"]!.map((x) => Guest.fromJson(x))),
      discussions: json["discussions"] == null
          ? []
          : List<Discussion>.from(json["discussions"]!.map((x) => Discussion.fromJson(x))),
      documents:
          json["documents"] == null ? [] : List<Document>.from(json["documents"]!.map((x) => Document.fromJson(x))),
      agendaItems:
          json["agendaItems"] == null ? [] : List<Agenda>.from(json["agendaItems"]!.map((x) => Agenda.fromJson(x))),
      location: Location.fromJson(json["location"] ?? {}),
      onlineMeetingUrl: json["onlineMeetingUrl"] ?? "",
      onlineMeetingToken: json["onlineMeetingToken"] ?? "",
      attendeeOnlineToken: json["attendeeOnlineToken"] ?? "",
      absenceRequests: json["absenceRequests"] == null
          ? []
          : List<AbsenceRequest>.from(json["absenceRequests"]!.map((x) => AbsenceRequest.fromJson(x))),
      guestSuggestions: json["guestSuggestions"] == null
          ? []
          : List<Guest>.from(json["guestSuggestions"]!.map((x) => Guest.fromJson(x))),
      decisions:
          json["decisions"] == null ? [] : List<Decision>.from(json["decisions"]!.map((x) => Decision.fromJson(x))),
      polls: json["polls"] == null ? [] : List<Poll>.from(json["polls"]!.map((x) => Poll.fromJson(x))),
      tasks: json["tasks"] == null ? [] : List<Task>.from(json["tasks"]!.map((x) => Task.fromJson(x))),
      minutes: Minutes.fromJson(json["minutes"] ?? {}),
      pollResults: json["pollResults"] == null
          ? []
          : List<PollResult>.from(json["pollResults"]!.map((x) => PollResult.fromJson(x))),
      mode: MeetingMode.fromIndex(json["mode"]),
      hijriDate: json["hijriDate"] ?? "",
      callerMembershipType: _membershipType(json["callerMembershipType"]),
    );
  }

  static MembershipType? _membershipType(Object? index) {
    final i = int.tryParse(index?.toString() ?? '');
    if (i == null || i < 0 || i >= MembershipType.values.length) return null;
    return MembershipType.values[i];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "meetingPlace": meetingPlace,
        "fromDate": fromDate?.toIso8601String(),
        "toDate": toDate?.toIso8601String(),
        "scheduledDate": scheduledDate?.toIso8601String(),
        "status": status.index,
        "committeeId": committeeId,
        "committeeName": committeeName,
        "hasRequestAbsence": hasRequestAbsence,
        "attendeesList": attendeesList.map((x) => x.toJson()).toList(),
        "guestsList": guestsList.map((x) => x.toJson()).toList(),
        "discussions": discussions.map((x) => x.toJson()).toList(),
        "documents": documents.map((x) => x.toJson()).toList(),
        "agendaItems": agendaItems.map((x) => x.toJson()).toList(),
        "location": location.toJson(),
        "onlineMeetingUrl": onlineMeetingUrl,
        "onlineMeetingToken": onlineMeetingToken,
        "attendeeOnlineToken": attendeeOnlineToken,
        "absenceRequests": absenceRequests.map((x) => x.toJson()).toList(),
        "guestSuggestions": guestSuggestions.map((x) => x.toJson()).toList(),
        "decisions": decisions.map((x) => x.toJson()).toList(),
        "polls": polls.map((x) => x.toJson()).toList(),
        "tasks": tasks.map((x) => x.toJson()).toList(),
        "minutes": minutes.toJson(),
        "pollResults": pollResults.map((x) => x.toJson()).toList(),
        "mode": mode?.index,
        "hijriDate": hijriDate,
        "callerMembershipType": callerMembershipType?.index,
      };
}

class AbsenceRequest {
  AbsenceRequest({
    required this.id,
    required this.party,
    required this.meetingId,
    required this.status,
    required this.date,
    this.reason = '',
  });

  final String id;
  final AbsenceRequestParty? party;
  final String meetingId;
  final num status;
  final DateTime? date;
  final String reason;

  AbsenceStatus get absenceStatus => AbsenceStatus.fromIndex(status);

  String get name => [party?.firstName, party?.middleName, party?.lastName]
      .whereType<String>()
      .where((e) => e.trim().isNotEmpty)
      .join(' ');

  factory AbsenceRequest.fromJson(Map<String, dynamic> json) {
    return AbsenceRequest(
      id: json["id"] ?? "",
      party: json["party"] == null ? null : AbsenceRequestParty.fromJson(json["party"]),
      meetingId: json["meetingId"] ?? "",
      status: json["status"] ?? 0,
      date: DateTime.tryParse(json["date"] ?? ""),
      reason: json["reason"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "party": party?.toJson(),
        "meetingId": meetingId,
        "status": status,
        "date": date?.toIso8601String(),
        "reason": reason,
      };
}

class AbsenceRequestParty {
  AbsenceRequestParty({
    required this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.personalPhoto,
  });

  final String id;
  final String firstName;
  final String middleName;
  final String lastName;
  final String personalPhoto;

  factory AbsenceRequestParty.fromJson(Map<String, dynamic> json) {
    return AbsenceRequestParty(
      id: json["id"] ?? "",
      firstName: json["firstName"] ?? "",
      middleName: json["middleName"] ?? "",
      lastName: json["lastName"] ?? "",
      personalPhoto: json["personalPhoto"]?.toString().fixUrl(initialImage: Assets.imagesAvatar) ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "middleName": middleName,
        "lastName": lastName,
        "personalPhoto": personalPhoto,
      };
}

class Decision {
  Decision({
    required this.id,
    required this.meetingId,
    required this.statement,
    required this.date,
    required this.number,
    required this.year,
  });

  final String id;
  final String meetingId;
  final String statement;
  final DateTime? date;

  /// Register number and year, null until the decision is published.
  final int? number;
  final int? year;

  /// "3/2026", or empty before publishing.
  String get numberLabel => number == null || year == null ? '' : '$number/$year';

  factory Decision.fromJson(Map<String, dynamic> json) {
    return Decision(
      id: json["id"] ?? "",
      meetingId: json["meetingId"] ?? "",
      statement: json["statement"] ?? "",
      date: DateTime.tryParse(json["date"] ?? ""),
      number: int.tryParse(json["number"]?.toString() ?? ""),
      year: int.tryParse(json["year"]?.toString() ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "meetingId": meetingId,
        "statement": statement,
        "date": date?.toIso8601String(),
        "number": number,
        "year": year,
      };
}

class Discussion {
  Discussion({
    required this.id,
    required this.meetingId,
    required this.topic,
    required this.date,
    required this.status,
    required this.comments,
  });

  final String id;
  final String meetingId;
  final String topic;
  final DateTime? date;
  final DiscussionStatus status;
  final List<DiscussionComment> comments;

  bool get haveMyComment => comments.firstWhereOrNull((e) => e.partyId == AppProvider.getParty.id) != null;

  DiscussionComment? get myComment => comments.firstWhereOrNull((e) => e.partyId == AppProvider.getParty.id);

  factory Discussion.fromJson(Map<String, dynamic> json) {
    return Discussion(
      id: json["id"] ?? "",
      meetingId: json["meetingId"] ?? "",
      topic: json["topic"] ?? "",
      date: DateTime.tryParse(json["date"] ?? ""),
      status: DiscussionStatus.values[json["status"] ?? 0],
      comments: json["comments"] == null
          ? []
          : List<DiscussionComment>.from(json["comments"]!.map((x) => DiscussionComment.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "meetingId": meetingId,
        "topic": topic,
        "date": date?.toIso8601String(),
        "status": status.index,
        "comments": comments.map((x) => x.toJson()).toList(),
      };
}

class DiscussionComment {
  DiscussionComment({
    required this.id,
    required this.text,
    required this.date,
    required this.partyId,
    required this.party,
    required this.discussionId,
  });

  final String id;
  final String text;
  final DateTime? date;
  final String partyId;
  final Party party;
  final String discussionId;

  bool get isMyComment => partyId == AppProvider.getParty.id;

  factory DiscussionComment.fromJson(Map<String, dynamic> json) {
    return DiscussionComment(
      id: json["id"] ?? "",
      text: json["text"] ?? "",
      date: DateTime.tryParse(json["date"] ?? ""),
      partyId: json["partyId"] ?? "",
      party: Party.fromJson(json["party"] ?? {}),
      discussionId: json["discussionId"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "date": date?.toIso8601String(),
        "partyId": partyId,
        "party": party.toJson(),
        "discussionId": discussionId,
      };
}

class Document {
  Document({
    required this.id,
    required this.documentDate,
    required this.name,
    required this.isPublished,
    required this.media,
  });

  final String id;
  final DateTime? documentDate;
  final String name;
  final bool isPublished;
  final Media? media;

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      id: json["id"] ?? "",
      documentDate: DateTime.tryParse(json["documentDate"] ?? ""),
      name: json["name"] ?? "",
      isPublished: json["isPublished"] ?? false,
      media: json["media"] == null ? null : Media.fromJson(json["media"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "documentDate": documentDate?.toIso8601String(),
        "name": name,
        "isPublished": isPublished,
        "media": media?.toJson(),
      };
}

class Media {
  Media({
    required this.id,
    required this.fileName,
    required this.originalFileName,
    required this.savedPath,
    required this.mime,
  });

  final String id;
  final String fileName;
  final String originalFileName;
  final String savedPath;
  final String mime;

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      id: json["id"] ?? "",
      fileName: json["fileName"] ?? "",
      originalFileName: json["originalFileName"] ?? "",
      savedPath: json["savedPath"] ?? "",
      mime: json["mime"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "fileName": fileName,
        "originalFileName": originalFileName,
        "savedPath": savedPath,
        "mime": mime,
      };
}

class Guest {
  Guest({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.company,
    required this.email,
    required this.phone,
    required this.meetingId,
    required this.partyId,
    required this.guestMeetingId,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String company;
  final String email;
  final String phone;
  final String meetingId;
  final String partyId;
  final String guestMeetingId;

  factory Guest.fromJson(Map<String, dynamic> json) {
    return Guest(
      id: json["id"] ?? "",
      firstName: json["firstName"] ?? "",
      lastName: json["lastName"] ?? "",
      company: json["company"] ?? "",
      email: json["email"] ?? "",
      phone: json["phone"] ?? "",
      meetingId: json["meetingID"] ?? "",
      partyId: json["partyID"] ?? "",
      guestMeetingId: json["meetingId"] ?? "",
    );
  }

  String get name => '$firstName $lastName';

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "company": company,
        "email": email,
        "phone": phone,
        "meetingID": meetingId,
        "partyID": partyId,
        "meetingId": guestMeetingId,
      };
}

class Location {
  Location({
    required this.id,
    required this.meetingId,
    required this.address,
    required this.locationType,
    required this.onlineMeetingLinks,
  });

  final String id;
  final String meetingId;
  final String address;
  final num locationType;
  final List<OnlineMeetingLink> onlineMeetingLinks;

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json["id"] ?? "",
      meetingId: json["meetingId"] ?? "",
      address: json["address"] ?? "",
      locationType: json["locationType"] ?? 0,
      onlineMeetingLinks: json["onlineMeetingLinks"] == null
          ? []
          : List<OnlineMeetingLink>.from(json["onlineMeetingLinks"]!.map((x) => OnlineMeetingLink.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "meetingId": meetingId,
        "address": address,
        "locationType": locationType,
        "onlineMeetingLinks": onlineMeetingLinks.map((x) => x.toJson()).toList(),
      };
}

class OnlineMeetingLink {
  OnlineMeetingLink({
    required this.link,
    required this.platform,
  });

  final String link;
  final num platform;

  factory OnlineMeetingLink.fromJson(Map<String, dynamic> json) {
    return OnlineMeetingLink(
      link: json["link"] ?? "",
      platform: json["platform"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "link": link,
        "platform": platform,
      };
}

class Minutes {
  Minutes({
    required this.id,
    required this.minuteId,
    required this.name,
    required this.date,
    required this.status,
    required this.media,
  });

  final String id;
  final String minuteId;
  final String name;
  final DateTime? date;

  /// `MinuteStatus`: 0 draft (under review), 1 published.
  final num status;
  final Media? media;

  /// `MinuteDto.id` (older payloads used `minuteId`).
  String get effectiveId => id.isNotEmpty ? id : minuteId;

  bool get isPublished => status == 1;

  factory Minutes.fromJson(Map<String, dynamic> json) {
    return Minutes(
      id: json["id"] ?? "",
      minuteId: json["minuteId"] ?? "",
      name: json["name"] ?? "",
      date: DateTime.tryParse(json["date"] ?? ""),
      status: json["status"] ?? 0,
      media: json["media"] == null ? null : Media.fromJson(json["media"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "minuteId": minuteId,
        "name": name,
        "date": date?.toIso8601String(),
        "status": status,
        "media": media?.toJson(),
      };
}

class Task {
  Task({
    required this.id,
    required this.description,
    required this.name,
    required this.startDate,
    required this.dueDate,
    required this.taskStatus,
    required this.meetingId,
    required this.meetingName,
    required this.memberTasks,
  });

  final String id;
  final String description;
  final String name;
  final DateTime? startDate;
  final DateTime? dueDate;
  final num taskStatus;
  final String meetingId;
  final String meetingName;
  final List<MemberTask> memberTasks;

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json["id"] ?? "",
      description: json["description"] ?? "",
      name: json["name"] ?? "",
      startDate: DateTime.tryParse(json["startDate"] ?? ""),
      dueDate: DateTime.tryParse(json["dueDate"] ?? ""),
      taskStatus: json["taskStatus"] ?? 0,
      meetingId: json["meetingId"] ?? "",
      meetingName: json["meetingName"] ?? "",
      memberTasks: json["memberTasks"] == null
          ? []
          : List<MemberTask>.from(json["memberTasks"]!.map((x) => MemberTask.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "name": name,
        "startDate": startDate?.toIso8601String(),
        "dueDate": dueDate?.toIso8601String(),
        "taskStatus": taskStatus,
        "meetingId": meetingId,
        "meetingName": meetingName,
        "memberTasks": memberTasks.map((x) => x.toJson()).toList(),
      };
}

class MemberTask {
  MemberTask({
    required this.id,
    required this.party,
    required this.meetingTaskId,
    required this.role,
  });

  final String id;
  final AbsenceRequestParty? party;
  final String meetingTaskId;
  final String role;

  factory MemberTask.fromJson(Map<String, dynamic> json) {
    return MemberTask(
      id: json["id"] ?? "",
      party: json["party"] == null ? null : AbsenceRequestParty.fromJson(json["party"]),
      meetingTaskId: json["meetingTaskId"] ?? "",
      role: json["role"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "party": party?.toJson(),
        "meetingTaskId": meetingTaskId,
        "role": role,
      };
}
