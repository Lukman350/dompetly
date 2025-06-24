import 'package:firebase_auth/firebase_auth.dart';

enum LoginType { google, email }

class AuthUser {
  final User? firebaseUser;
  final String? token;
  final String? userId;
  final String? username;
  final int? pin;
  final LoginType? loginType;

  const AuthUser({
    this.firebaseUser,
    this.token,
    this.userId,
    this.loginType,
    this.username,
    this.pin,
  });

  factory AuthUser.fromFirebaseUser(User user) {
    return AuthUser(firebaseUser: user);
  }

  String get uid => firebaseUser?.uid ?? '';

  String get email => firebaseUser?.email ?? '';

  String get displayName => firebaseUser?.displayName ?? '';

  String get photoURL => firebaseUser?.photoURL ?? '';

  bool get isAnonymous => firebaseUser?.isAnonymous ?? false;

  bool get isEmailVerified => firebaseUser?.emailVerified ?? false;

  bool get isLoggedIn => firebaseUser != null;

  AuthUser copyWith({
    String? token,
    String? userId,
    LoginType? loginType,
    User? firebaseUser,
    String? username,
    int? pin,
  }) {
    return AuthUser(
      firebaseUser: firebaseUser ?? this.firebaseUser,
      token: token ?? this.token,
      userId: userId ?? this.userId,
      loginType: loginType ?? this.loginType,
      username: username ?? this.username,
      pin: pin ?? this.pin,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'userId': userId,
      'loginType': loginType?.toString(),
      'username': username,
      'pin': pin,
    };
  }

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      token: json['token'],
      userId: json['userId'],
      loginType: LoginType.values.firstWhere(
        (type) => type.toString() == json['loginType'],
        orElse: () => LoginType.email,
      ),
      username: json['username'],
      pin: json['pin'],
    );
  }

  @override
  String toString() {
    return 'AuthUser(firebaseUser: $firebaseUser, token: $token, userId: $userId, loginType: $loginType, username: $username, pin: $pin)';
  }
}
