class LoginResponse {
  LoginResponse({
    required this.tokenType,
    required this.accessToken,
    required this.expiresIn,
    required this.user,
    required this.twoStepsRequired,
    required this.claims,
  });

  final String tokenType;
  final String accessToken;
  final num expiresIn;
  final User? user;
  final bool twoStepsRequired;
  final Claims? claims;

  factory LoginResponse.fromJson(Map<String, dynamic> json){
    return LoginResponse(
      tokenType: json["tokenType"] ?? "",
      accessToken: json["accessToken"] ?? "",
      expiresIn: json["expiresIn"] ?? 0,
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      twoStepsRequired: json["twoStepsRequired"] ?? false,
      claims: json["claims"] == null ? null : Claims.fromJson(json["claims"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "tokenType": tokenType,
    "accessToken": accessToken,
    "expiresIn": expiresIn,
    "user": user?.toJson(),
    "twoStepsRequired": twoStepsRequired,
    "claims": claims?.toJson(),
  };

}

class Claims {
  Claims({
    required this.items,
    required this.pages,
    required this.modules,
    required this.blocks,
    required this.operations,
  });

  final List<dynamic> items;
  final List<dynamic> pages;
  final List<dynamic> modules;
  final List<String> blocks;
  final List<String> operations;

  factory Claims.fromJson(Map<String, dynamic> json){
    return Claims(
      items: json["items"] == null ? [] : List<dynamic>.from(json["items"]!.map((x) => x)),
      pages: json["pages"] == null ? [] : List<dynamic>.from(json["pages"]!.map((x) => x)),
      modules: json["modules"] == null ? [] : List<dynamic>.from(json["modules"]!.map((x) => x)),
      blocks: json["blocks"] == null ? [] : List<String>.from(json["blocks"]!.map((x) => x)),
      operations: json["operations"] == null ? [] : List<String>.from(json["operations"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "items": items.map((x) => x).toList(),
    "pages": pages.map((x) => x).toList(),
    "modules": modules.map((x) => x).toList(),
    "blocks": blocks.map((x) => x).toList(),
    "operations": operations.map((x) => x).toList(),
  };

}

class User {
  User({
    required this.id,
    required this.email,
    required this.userName,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.imageUrl,
    required this.workPhoneNumber,
    required this.phoneNumber,
    required this.phoneNumberCode,
    required this.attribute,
    required this.status,
    required this.customerId,
  });

  final String id;
  final String email;
  final String userName;
  final String firstName;
  final String middleName;
  final String lastName;
  final dynamic imageUrl;
  final String workPhoneNumber;
  final String phoneNumber;
  final String phoneNumberCode;
  final String attribute;
  final num status;
  final String customerId;

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json["id"] ?? "",
      email: json["email"] ?? "",
      userName: json["userName"] ?? "",
      firstName: json["firstName"] ?? "",
      middleName: json["middleName"] ?? "",
      lastName: json["lastName"] ?? "",
      imageUrl: json["imageUrl"],
      workPhoneNumber: json["workPhoneNumber"] ?? "",
      phoneNumber: json["phoneNumber"] ?? "",
      phoneNumberCode: json["phoneNumberCode"] ?? "",
      attribute: json["attribute"] ?? "",
      status: json["status"] ?? 0,
      customerId: json["customerId"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "userName": userName,
    "firstName": firstName,
    "middleName": middleName,
    "lastName": lastName,
    "imageUrl": imageUrl,
    "workPhoneNumber": workPhoneNumber,
    "phoneNumber": phoneNumber,
    "phoneNumberCode": phoneNumberCode,
    "attribute": attribute,
    "status": status,
    "customerId": customerId,
  };

}
