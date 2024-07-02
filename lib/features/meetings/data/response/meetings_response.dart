import 'package:mms/core/extensions/extensions.dart';

import '../../../../core/strings/enum_manager.dart';
import '../../../../generated/assets.dart';
import '../../../agendas/data/response/agendas_response.dart';
import '../../../attendees/data/response/attendee_response.dart';
import '../../../poll/data/response/poll_response.dart';

class MeetingsResponse {
  MeetingsResponse({
    required this.items,
  });

  final List<Meeting> items;

  factory MeetingsResponse.fromJson(Map<String, dynamic> json) {
    return MeetingsResponse(
      items: json["items"] == null
          ? []
          : List<Meeting>.from(json["items"]!.map((x) => Meeting.fromJson(x))),
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
    required this.absenceRequests,
    required this.guestSuggestions,
    required this.decisions,
    required this.polls,
    required this.tasks,
    required this.minutes,
    required this.pollResults,
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
  final List<AbsenceRequest> absenceRequests;
  final List<Guest> guestSuggestions;
  final List<Decision> decisions;
  final List<Poll> polls;
  final List<Task> tasks;
  final Minutes minutes;
  final List<PollResult> pollResults;

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
          : List<Attendee>.from(
              json["attendeesList"]!.map((x) => Attendee.fromJson(x))),
      guestsList: json["guestsList"] == null
          ? []
          : List<Guest>.from(json["guestsList"]!.map((x) => Guest.fromJson(x))),
      discussions: json["discussions"] == null
          ? []
          : List<Discussion>.from(
              json["discussions"]!.map((x) => Discussion.fromJson(x))),
      documents: json["documents"] == null
          ? []
          : List<Document>.from(
              json["documents"]!.map((x) => Document.fromJson(x))),
      agendaItems: json["agendaItems"] == null
          ? []
          : List<Agenda>.from(
              json["agendaItems"]!.map((x) => Agenda.fromJson(x))),
      location: Location.fromJson(json["location"] ?? {}),
      absenceRequests: json["absenceRequests"] == null
          ? []
          : List<AbsenceRequest>.from(
              json["absenceRequests"]!.map((x) => AbsenceRequest.fromJson(x))),
      guestSuggestions: json["guestSuggestions"] == null
          ? []
          : List<Guest>.from(
              json["guestSuggestions"]!.map((x) => Guest.fromJson(x))),
      decisions: json["decisions"] == null
          ? []
          : List<Decision>.from(
              json["decisions"]!.map((x) => Decision.fromJson(x))),
      polls: json["polls"] == null
          ? []
          : List<Poll>.from(json["polls"]!.map((x) => Poll.fromJson(x))),
      tasks: json["tasks"] == null
          ? []
          : List<Task>.from(json["tasks"]!.map((x) => Task.fromJson(x))),
      minutes: Minutes.fromJson(json["minutes"] ?? {}),
      pollResults: json["pollResults"] == null
          ? []
          : List<PollResult>.from(
              json["pollResults"]!.map((x) => PollResult.fromJson(x))),
    );
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
        "absenceRequests": absenceRequests.map((x) => x.toJson()).toList(),
        "guestSuggestions": guestSuggestions.map((x) => x.toJson()).toList(),
        "decisions": decisions.map((x) => x.toJson()).toList(),
        "polls": polls.map((x) => x.toJson()).toList(),
        "tasks": tasks.map((x) => x.toJson()).toList(),
        "minutes": minutes.toJson(),
        "pollResults": pollResults.map((x) => x.toJson()).toList(),
      };
}

class AbsenceRequest {
  AbsenceRequest({
    required this.id,
    required this.party,
    required this.meetingId,
    required this.status,
    required this.date,
  });

  final String id;
  final AbsenceRequestParty? party;
  final String meetingId;
  final num status;
  final DateTime? date;

  factory AbsenceRequest.fromJson(Map<String, dynamic> json) {
    return AbsenceRequest(
      id: json["id"] ?? "",
      party: json["party"] == null
          ? null
          : AbsenceRequestParty.fromJson(json["party"]),
      meetingId: json["meetingId"] ?? "",
      status: json["status"] ?? 0,
      date: DateTime.tryParse(json["date"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "party": party?.toJson(),
        "meetingId": meetingId,
        "status": status,
        "date": date?.toIso8601String(),
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
      personalPhoto:
      json["personalPhoto"]?.toString().fixUrl(initialImage:Assets.imagesAvatar) ?? '',
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
  });

  final String id;
  final String meetingId;
  final String statement;
  final DateTime? date;

  factory Decision.fromJson(Map<String, dynamic> json) {
    return Decision(
      id: json["id"] ?? "",
      meetingId: json["meetingId"] ?? "",
      statement: json["statement"] ?? "",
      date: DateTime.tryParse(json["date"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "meetingId": meetingId,
        "statement": statement,
        "date": date?.toIso8601String(),
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
  final num status;
  final List<DiscussionComment> comments;

  factory Discussion.fromJson(Map<String, dynamic> json) {
    return Discussion(
      id: json["id"] ?? "",
      meetingId: json["meetingId"] ?? "",
      topic: json["topic"] ?? "",
      date: DateTime.tryParse(json["date"] ?? ""),
      status: json["status"] ?? 0,
      comments: json["comments"] == null
          ? []
          : List<DiscussionComment>.from(
              json["comments"]!.map((x) => DiscussionComment.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "meetingId": meetingId,
        "topic": topic,
        "date": date?.toIso8601String(),
        "status": status,
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
  final PurpleParty? party;
  final String discussionId;

  factory DiscussionComment.fromJson(Map<String, dynamic> json) {
    return DiscussionComment(
      id: json["id"] ?? "",
      text: json["text"] ?? "",
      date: DateTime.tryParse(json["date"] ?? ""),
      partyId: json["partyId"] ?? "",
      party: json["party"] == null ? null : PurpleParty.fromJson(json["party"]),
      discussionId: json["discussionId"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "date": date?.toIso8601String(),
        "partyId": partyId,
        "party": party?.toJson(),
        "discussionId": discussionId,
      };
}

class PurpleParty {
  PurpleParty({
    required this.id,
    required this.userName,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.dob,
    required this.gender,
    required this.address,
    required this.email,
    required this.mobile,
    required this.phone,
    required this.workPhone,
    required this.personalPhoto,
    required this.company,
    required this.isUserId,
    required this.isCustomerId,
    required this.workUnitId,
    required this.workUnit,
    required this.committeesNumber,
    required this.tasksNumber,
  });

  final String id;
  final String userName;
  final String firstName;
  final String middleName;
  final String lastName;
  final DateTime? dob;
  final num gender;
  final String address;
  final String email;
  final String mobile;
  final String phone;
  final String workPhone;
  final String personalPhoto;
  final String company;
  final String isUserId;
  final String isCustomerId;
  final String workUnitId;
  final String workUnit;
  final num committeesNumber;
  final num tasksNumber;

  factory PurpleParty.fromJson(Map<String, dynamic> json) {
    return PurpleParty(
      id: json["id"] ?? "",
      userName: json["userName"] ?? "",
      firstName: json["firstName"] ?? "",
      middleName: json["middleName"] ?? "",
      lastName: json["lastName"] ?? "",
      dob: DateTime.tryParse(json["dob"] ?? ""),
      gender: json["gender"] ?? 0,
      address: json["address"] ?? "",
      email: json["email"] ?? "",
      mobile: json["mobile"] ?? "",
      phone: json["phone"] ?? "",
      workPhone: json["workPhone"] ?? "",
      personalPhoto:
      json["personalPhoto"]?.toString().fixUrl(initialImage:Assets.imagesAvatar) ?? '',
      company: json["company"] ?? "",
      isUserId: json["isUserId"] ?? "",
      isCustomerId: json["isCustomerId"] ?? "",
      workUnitId: json["workUnitId"] ?? "",
      workUnit: json["workUnit"] ?? "",
      committeesNumber: json["committeesNumber"] ?? 0,
      tasksNumber: json["tasksNumber"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "userName": userName,
        "firstName": firstName,
        "middleName": middleName,
        "lastName": lastName,
        "dob": dob?.toIso8601String(),
        "gender": gender,
        "address": address,
        "email": email,
        "mobile": mobile,
        "phone": phone,
        "workPhone": workPhone,
        "personalPhoto": personalPhoto,
        "company": company,
        "isUserId": isUserId,
        "isCustomerId": isCustomerId,
        "workUnitId": workUnitId,
        "workUnit": workUnit,
        "committeesNumber": committeesNumber,
        "tasksNumber": tasksNumber,
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

  get name => '$firstName $lastName';

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
          : List<OnlineMeetingLink>.from(json["onlineMeetingLinks"]!
              .map((x) => OnlineMeetingLink.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "meetingId": meetingId,
        "address": address,
        "locationType": locationType,
        "onlineMeetingLinks":
            onlineMeetingLinks.map((x) => x.toJson()).toList(),
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
  final num status;
  final Media? media;

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
          : List<MemberTask>.from(
              json["memberTasks"]!.map((x) => MemberTask.fromJson(x))),
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
      party: json["party"] == null
          ? null
          : AbsenceRequestParty.fromJson(json["party"]),
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
