class ResponseUtil {
  final String code;

  ResponseUtil({required this.code});

  String get responseRegister {
    switch (code) {
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      case 'invalid-email':
        return 'The email address is badly formatted.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled.';
      case 'weak-password':
        return 'The password is not strong enough.';
      case 'too-many-requests':
        return 'Too many requests. Try again later.';
      case 'user-token-expired':
        return 'The user is no longer authenticated since his refresh token has been expired.';
      case 'network-request-failed':
        return 'There was a network request error, for example the user doesn\'t have internet connection.';
      default:
        return 'Something went wrong.';
    }
  }

  String get responseLogin {
    switch (code) {
      case 'invalid-email':
        return 'The email address is badly formatted.';

      case 'user-disabled':
        return 'The user corresponding to the given email has been disabled.';

      case 'user-not-found':
        return 'There is no user corresponding to the given email.';

      case 'wrong-password':
        return 'The password is invalid for the given email, or the account corresponding to the email does not have a password set.';

      case 'too-many-requests':
        return 'Too many requests. Try again later.';

      case 'user-token-expired':
        return 'The user is no longer authenticated since his refresh token has been expired.';

      case 'network-request-failed':
        return 'There was a network request error, for example the user doesn\'t have internet connection.';

      case 'INVALID_LOGIN_CREDENTIALS' || 'invalid-credential':
        return 'The email or password is invalid.';

      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled. Enable email/password accounts in the Firebase Console, under the Auth tab.';

      default:
        return 'Something went wrong.';
    }
  }
}
