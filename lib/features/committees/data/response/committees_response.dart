class CommitteesResponse {
  CommitteesResponse({
    required this.data,
  });

  final List<Committee> data;

  factory CommitteesResponse.fromJson(Map<String, dynamic> json) {
    return CommitteesResponse(
      data: json['data'] == null
          ? []
          : List<Committee>.from(
              (json['data']).map((x) => Committee.fromJson(x)),
            ),
    );
  }
}

class Committee {
  Committee({
    required this.id,
    required this.name,
    required this.formationDate,
    required this.statement,
    required this.description,
    required this.members,
    required this.documents,
    required this.goals,
  });

  final String id;
  final String name;
  final DateTime? formationDate;
  final String statement;
  final String description;
  final List<Member> members;
  final List<Document> documents;
  final List<Goal> goals;

  factory Committee.fromJson(Map<String, dynamic> json) {
    return Committee(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      formationDate: DateTime.tryParse(json["formationDate"] ?? ""),
      statement: json["statement"] ?? "",
      description: json["description"] ?? "",
      members: json["members"] == null
          ? []
          : List<Member>.from(json["members"]!.map((x) => Member.fromJson(x))),
      documents: json["documents"] == null
          ? []
          : List<Document>.from(
              json["documents"]!.map((x) => Document.fromJson(x))),
      goals: json["goals"] == null
          ? []
          : List<Goal>.from(json["goals"]!.map((x) => Goal.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "formationDate": formationDate?.toIso8601String(),
        "statement": statement,
        "description": description,
        "members": members.map((x) => x.toJson()).toList(),
        "documents": documents.map((x) => x.toJson()).toList(),
        "goals": goals.map((x) => x.toJson()).toList(),
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
  final Media media;

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      id: json["id"] ?? "",
      documentDate: DateTime.tryParse(json["documentDate"] ?? ""),
      name: json["name"] ?? "",
      isPublished: json["isPublished"] ?? false,
      media: Media.fromJson(json["media"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "documentDate": documentDate?.toIso8601String(),
        "name": name,
        "isPublished": isPublished,
        "media": media.toJson(),
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

class Goal {
  Goal({
    required this.id,
    required this.name,
    required this.description,
    required this.goalDate,
    required this.committeeId,
    required this.tasks,
  });

  final String id;
  final String name;
  final String description;
  final DateTime? goalDate;
  final String committeeId;
  final List<Task> tasks;

  factory Goal.fromJson(Map<String, dynamic> json) {
    return Goal(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      description: json["description"] ?? "",
      goalDate: DateTime.tryParse(json["goalDate"] ?? ""),
      committeeId: json["committeeId"] ?? "",
      tasks: json["tasks"] == null
          ? []
          : List<Task>.from(json["tasks"]!.map((x) => Task.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "goalDate": goalDate?.toIso8601String(),
        "committeeId": committeeId,
        "tasks": tasks.map((x) => x.toJson()).toList(),
      };
}

class Task {
  Task({
    required this.id,
    required this.name,
    required this.description,
    required this.startDate,
    required this.dueDate,
    required this.goalId,
  });

  final String id;
  final String name;
  final String description;
  final DateTime? startDate;
  final DateTime? dueDate;
  final String goalId;

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      description: json["description"] ?? "",
      startDate: DateTime.tryParse(json["startDate"] ?? ""),
      dueDate: DateTime.tryParse(json["dueDate"] ?? ""),
      goalId: json["goalId"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "startDate": startDate?.toIso8601String(),
        "dueDate": dueDate?.toIso8601String(),
        "goalId": goalId,
      };
}

class Member {
  Member({
    required this.id,
    required this.membershipType,
    required this.partyId,
    required this.party,
    required this.committeeId,
    required this.isRoleId,
    required this.isRoleName,
  });

  final String id;
  final num membershipType;
  final String partyId;
  final Party party;
  final String committeeId;
  final String isRoleId;
  final String isRoleName;

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json["id"] ?? "",
      membershipType: json["membershipType"] ?? 0,
      partyId: json["partyId"] ?? "",
      party: Party.fromJson(json["party"] ?? {}),
      committeeId: json["committeeId"] ?? "",
      isRoleId: json["isRoleId"] ?? "",
      isRoleName: json["isRoleName"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "membershipType": membershipType,
        "partyId": partyId,
        "party": party.toJson(),
        "committeeId": committeeId,
        "isRoleId": isRoleId,
        "isRoleName": isRoleName,
      };
}

class Party {
  Party({
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

  factory Party.fromJson(Map<String, dynamic> json) {
    return Party(
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
      personalPhoto: json["personalPhoto"] ?? "",
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
