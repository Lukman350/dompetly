class LocalUser {
  final String id;
  final String username;
  final String email;
  final String? photoUrl;
  final int? pin;
  final String? token;

  LocalUser({
    required this.id,
    required this.username,
    required this.email,
    this.photoUrl,
    this.pin,
    this.token,
  });

  factory LocalUser.fromJson(Map<String, dynamic> json) {
    return LocalUser(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      photoUrl: json['photoProfile'],
      pin: json['pin'],
      token: json['token'],
    );
  }

  @override
  String toString() {
    return 'LocalUser(id: $id, username: $username, email: $email, photoUrl: $photoUrl, pin: $pin, token: $token)';
  }
}
