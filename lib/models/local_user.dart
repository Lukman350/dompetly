import 'package:dompetly/models/auth_user.dart';

class LocalUser {
  final String id;
  final String username;
  final String email;
  final String? photoUrl;
  final String? pin;
  final String? token;
  final String? firebaseUid;
  final LoginType? loginType;

  LocalUser({
    required this.id,
    required this.username,
    required this.email,
    this.photoUrl,
    this.pin,
    this.token,
    this.firebaseUid,
    this.loginType,
  });

  factory LocalUser.fromJson(Map<String, dynamic> json) {
    return LocalUser(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      photoUrl: json['photoProfile'],
      pin: json['pin'],
      token: json['token'],
      firebaseUid: json['firebaseUid'],
      loginType: json['firebaseAccountType'] == 'emailPassword'
          ? LoginType.email
          : LoginType.google,
    );
  }

  @override
  String toString() {
    return 'LocalUser{id: $id, username: $username, email: $email, photoUrl: $photoUrl, pin: $pin, token: $token, firebaseUid: $firebaseUid, loginType: $loginType}';
  }
}
