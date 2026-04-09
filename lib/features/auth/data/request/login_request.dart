class LoginRequest {
  // String? userName = 'maissam@gmail.com';
  String? userName = 'abd-member@gmail.com';
  // String? userName = 'party1@gmail.com';
  // String? userName = 'mms@coretech.com';"email": "maissam@gmail.com",
  //     "password": "P@ssw0rd2026",
  String? password = 'P@ssw0rd2026';
  String? programKey;

  LoginRequest({
    this.userName = 'abd-member@gmail.com',
    // this.userName = 'party1@gmail.com',
    // this.userName = 'mms@coretech.com',
    this.password = 'P@ssw0rd2026',
    this.programKey,
  });

  LoginRequest copyWith({
    String? userName,
    String? password,
    String? programKey,
  }) {
    return LoginRequest(
      userName: userName ?? this.userName,
      password: password ?? this.password,
      programKey: programKey ?? this.programKey,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': userName,
      'password': password,
      'verification_code': programKey,
      'programKey': 'c7V9hHLSBKKJAGdMakSA4DUdlF05Q4SK/y6OaUQwmh36Qgm/l7u9GPt6R5+rDlX65D8=',
    };
  }
}
