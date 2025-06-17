class UserRequest {
  final String? email;
  final String? password;
  final String? username;
  final String? confirmPassword;

  UserRequest({this.email, this.password, this.username, this.confirmPassword});

  Map<String, dynamic> toJsonLogin() {
    return {'email': email, 'password': password};
  }

  Map<String, dynamic> toJsonRegister() {
    return {
      'email': email,
      'password': password,
      'username': username,
      'confirmPassword': confirmPassword,
    };
  }
}
