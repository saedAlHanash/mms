class LoginRequest {
  // String? userName = 'maissama@gmail.com';
  String? userName = 'party1@gmail.com';
  String? password = 'P@ssw0rd2024';
  String? programKey;

  LoginRequest({
    // this.userName = 'maissama@gmail.com',
    this.userName = 'party1@gmail.com',
    this.password = 'P@ssw0rd2024',
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
      'identifire': userName,
      'password': password,
      'verification_code': programKey,
      'programKey': 'c7V9hHLSBKKJAGdMakSA4DUdlF05Q4SK/y6OaUQwmh36Qgm/l7u9GPt6R5+rDlX65D8=',
    };
  }
}
