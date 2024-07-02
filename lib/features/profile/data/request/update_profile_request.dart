import 'package:mms/core/api_manager/api_service.dart';
import 'package:mms/core/app/app_provider.dart';
import 'package:mms/core/extensions/extensions.dart';

import '../../../../core/strings/enum_manager.dart';
import '../../../../generated/assets.dart';

class UpdatePartyRequest {
  UpdatePartyRequest({
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

  String? id;
  String? userName;
  String? firstName;
  String? middleName;
  String? lastName;
  DateTime? dob;
  GenderEnum? gender;
  String? address;
  String? email;
  String? mobile;
  String? phone;
  String? workPhone;
  String? personalPhoto;
  String? company;
  String? isUserId;
  String? isCustomerId;
  String? workUnitId;
  String? workUnit;
  num? committeesNumber;
  num? tasksNumber;

  final profileImageUrl = UploadFile(
    nameField: 'File',
    initialImage: AppProvider.getParty.personalPhoto,
  );

  factory UpdatePartyRequest.fromJson(Map<String, dynamic> json) {
    return UpdatePartyRequest(
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
      personalPhoto: json["personalPhoto"]
              ?.toString()
              .fixUrl(initialImage: Assets.imagesAvatar) ??
          '',
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
        "dob": dob?.formatDateToRequest,
        "gender": gender?.index,
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
