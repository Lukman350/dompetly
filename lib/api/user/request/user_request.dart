import 'package:dompetly/models/auth_user.dart';

class UserRequest {
  final String? email;
  final String? password;
  final String? username;
  final String? confirmPassword;
  final LoginType? loginType;
  final String? firebaseUid;
  final String? photoUrl;

  UserRequest({
    this.email,
    this.password,
    this.username,
    this.confirmPassword,
    this.loginType = LoginType.email,
    this.firebaseUid,
    this.photoUrl,
  });

  Map<String, dynamic> toJsonLogin() {
    if (loginType == LoginType.google) {
      return {
        'email': email,
        'firebaseUid': firebaseUid,
        'firebaseAccountType': loginType?.name,
      };
    }

    return {
      'email': email,
      'password': password,
      'firebaseUid': firebaseUid,
      'firebaseAccountType': loginType?.name,
    };
  }

  Map<String, dynamic> toJsonRegister() {
    return {
      'email': email,
      'password': password,
      'username': username,
      'confirmPassword': confirmPassword,
      'firebaseAccountType': loginType?.name,
      'firebaseUid': firebaseUid,
      'photoProfile': photoUrl,
    };
  }

  UserRequest copyWith({
    String? email,
    String? password,
    String? username,
    String? confirmPassword,
    LoginType? loginType,
    String? firebaseUid,
    String? photoUrl,
  }) {
    return UserRequest(
      email: email ?? this.email,
      password: password ?? this.password,
      username: username ?? this.username,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      loginType: loginType ?? this.loginType,
      firebaseUid: firebaseUid ?? this.firebaseUid,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}
