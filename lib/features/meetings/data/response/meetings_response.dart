import '../../../../core/strings/enum_manager.dart';
import '../../../agendas/data/response/agendas_response.dart';
import '../../../attendees/data/response/attendee_response.dart';
import '../../../documents/data/response/documents_response.dart';

class MeetingsResponse {
  MeetingsResponse({
    required this.items,
    required this.currentPage,
    required this.totalPages,
    required this.pageSize,
    required this.totalCount,
    required this.hasPrevious,
    required this.hasNext,
  });

  final List<Meeting> items;
  final num currentPage;
  final num totalPages;
  final num pageSize;
  final num totalCount;
  final bool hasPrevious;
  final bool hasNext;

  factory MeetingsResponse.fromJson(Map<String, dynamic> json) {
    return MeetingsResponse(
      items: json["items"] == null
          ? []
          : List<Meeting>.from(json["items"]!.map((x) => Meeting.fromJson(x))),
      currentPage: json["currentPage"] ?? 0,
      totalPages: json["totalPages"] ?? 0,
      pageSize: json["pageSize"] ?? 0,
      totalCount: json["totalCount"] ?? 0,
      hasPrevious: json["hasPrevious"] ?? false,
      hasNext: json["hasNext"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "items": items.map((x) => x.toJson()).toList(),
        "currentPage": currentPage,
        "totalPages": totalPages,
        "pageSize": pageSize,
        "totalCount": totalCount,
        "hasPrevious": hasPrevious,
        "hasNext": hasNext,
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
    required this.locationDto,
    required this.absenceRequests,
    required this.guestSuggestions,
    required this.decisions,
    required this.polls,
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
  final LocationDto? locationDto;
  final List<AbsenceRequest> absenceRequests;
  final List<Guest> guestSuggestions;
  final List<Decision> decisions;
  final List<Discussion> polls;

  factory Meeting.fromJson(Map<String, dynamic> json) {
    return Meeting(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      meetingPlace: json["meetingPlace"] ?? "",
      hasRequestAbsence: json["hasRequestAbsence"] ?? false,
      fromDate: DateTime.tryParse(json["fromDate"] ?? ""),
      toDate: DateTime.tryParse(json["toDate"] ?? ""),
      scheduledDate: DateTime.tryParse(json["scheduledDate"] ?? ""),
      status: MeetingStatus.values[json["status"] ?? 0],
      committeeId: json["committeeId"] ?? "",
      committeeName: json["committeeName"] ?? "",
      attendeesList: json["attendeesList"] == null
          ? []
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
      locationDto: json["locationDto"] == null
          ? null
          : LocationDto.fromJson(json["locationDto"]),
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
          : List<Discussion>.from(
              json["polls"]!.map((x) => Discussion.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "meetingPlace": meetingPlace,
        "hasRequestAbsence": hasRequestAbsence,
        "fromDate": fromDate?.toIso8601String(),
        "toDate": toDate?.toIso8601String(),
        "scheduledDate": scheduledDate?.toIso8601String(),
        "status": status.index,
        "committeeId": committeeId,
        "committeeName": committeeName,
        "attendeesList": attendeesList.map((x) => x.toJson()).toList(),
        "guestsList": guestsList.map((x) => x.toJson()).toList(),
        "discussions": discussions.map((x) => x.toJson()).toList(),
        "documents": documents.map((x) => x.toJson()).toList(),
        "agendaItems": agendaItems.map((x) => x.toJson()).toList(),
        "locationDto": locationDto?.toJson(),
        "absenceRequests": absenceRequests.map((x) => x.toJson()).toList(),
        "guestSuggestions": guestSuggestions.map((x) => x.toJson()).toList(),
        "decisions": decisions.map((x) => x.toJson()).toList(),
        "polls": polls.map((x) => x.toJson()).toList(),
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
      personalPhoto: json["personalPhoto"] ?? "",
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
    required this.options,
  });

  final String id;
  final String meetingId;
  final String topic;
  final DateTime? date;
  final num status;
  final List<Comment> comments;
  final List<Option> options;

  factory Discussion.fromJson(Map<String, dynamic> json) {
    return Discussion(
      id: json["id"] ?? "",
      meetingId: json["meetingId"] ?? "",
      topic: json["topic"] ?? "",
      date: DateTime.tryParse(json["date"] ?? ""),
      status: json["status"] ?? 0,
      comments: json["comments"] == null
          ? []
          : List<Comment>.from(
              json["comments"]!.map((x) => Comment.fromJson(x))),
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
        "status": status,
        "comments": comments.map((x) => x.toJson()).toList(),
        "options": options.map((x) => x.toJson()).toList(),
      };
}

class Option {
  Option({
    required this.id,
    required this.option,
  });

  final String id;
  final String option;

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json["id"] ?? "",
      option: json["option"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "option": option,
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

class LocationDto {
  LocationDto({
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

  factory LocationDto.fromJson(Map<String, dynamic> json) {
    return LocationDto(
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
