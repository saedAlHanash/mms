import '../../../../core/strings/enum_manager.dart';

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
  final MembershipType membershipType;
  final String partyId;
  final Party party;
  final String committeeId;
  final String isRoleId;
  final String isRoleName;

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json["id"] ?? "",
      membershipType: MembershipType.values[json["membershipType"] ?? 0],
      partyId: json["partyId"] ?? "",
      party: Party.fromJson(json["party"] ?? {}),
      committeeId: json["committeeId"] ?? "",
      isRoleId: json["isRoleId"] ?? "",
      isRoleName: json["isRoleName"] ?? "",
    );
  }

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "membershipType": membershipType.index,
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
  final GenderEnum gender;
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

  String get name => '$firstName $lastName';

  factory Party.fromJson(Map<String, dynamic> json) {
    return Party(
      id: json["id"] ?? "",
      userName: json["userName"] ?? "",
      firstName: json["firstName"] ?? "",
      middleName: json["middleName"] ?? "",
      lastName: json["lastName"] ?? "",
      dob: DateTime.tryParse(json["dob"] ?? ""),
      gender: GenderEnum.values[json["gender"] ?? 0],
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

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "userName": userName,
        "firstName": firstName,
        "middleName": middleName,
        "lastName": lastName,
        "dob": dob?.toIso8601String(),
        "gender": gender.index,
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
