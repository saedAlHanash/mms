class LoginRequest {
  String? userName;
  String? password;
  String? programKey;

  LoginRequest({
    this.userName,
    this.password,
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
      'programKey':
          'c7V9hHLSBKKJAGdMakSA4DUdlF05Q4SK/y6OaUQwmh36Qgm/l7u9GPt6R5+rDlX65D8=',
    };
  }
}
