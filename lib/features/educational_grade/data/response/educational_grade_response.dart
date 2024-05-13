import 'package:mms/core/extensions/extensions.dart';

import '../../../../core/util/abstraction.dart';

class EducationalGradeResponse {
  EducationalGradeResponse({
    required this.data,
  });

  final List<EducationalGrade> data;

  factory EducationalGradeResponse.fromJson(Map<String, dynamic> json) {
    return EducationalGradeResponse(
      data: json["data"] == null
          ? []
          : List<EducationalGrade>.from(
              json["data"]!.map((x) => EducationalGrade.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class EducationalGrade {
  EducationalGrade({
    required this.id,
    required this.name,
    required this.photo,
  });

  final int id;
  final String name;
  final String photo;

  factory EducationalGrade.fromJson(Map<String, dynamic> json) {
    return EducationalGrade(
      id: json["id"].toString().tryParseOrZeroInt,
      name: json["name"] ?? "",
      photo: json["photo"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photo": photo,
      };
}
