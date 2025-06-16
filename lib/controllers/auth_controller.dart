import 'package:dompetly/api/base_response.dart';
import 'package:dompetly/api/user/api_user.dart';
import 'package:dompetly/api/user/request/user_request.dart';
import 'package:dompetly/models/local_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum LoginType { google, email }

class AuthController extends GetxController {
  static AuthController get to => Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rxn<User> firebaseUser = Rxn<User>();
  final Rxn<LocalUser> localUser = Rxn<LocalUser>();
  LoginType? loginType;

  @override
  void onInit() {
    firebaseUser.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        Get.snackbar("Error", "Google login cancelled by user");
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);

      loginType = LoginType.google;

      Get.snackbar("Success", "Google login successful");
    } catch (e) {
      print(e);
      Get.snackbar("Error", "There was an error logging in with Google");
    }
  }

  Future<bool> signInWithEmail({required UserRequest request}) async {
    try {
      BaseResponse<LocalUser?> response = await ApiUser.login(request: request);

      if (!response.success) {
        Get.snackbar("Error", response.message ?? "Unknown error");
        return false;
      }

      localUser.value = response.data;
      loginType = LoginType.email;

      Get.snackbar("Success", "Login successful");

      return true;
    } catch (e) {
      print(e);
      Get.snackbar(
        "Error",
        "There was an error logging in with email and password",
      );

      return false;
    }
  }

  Future<void> signOut() async {
    if (firebaseUser.value != null) {
      await _auth.signOut();
      await GoogleSignIn().signOut();
    }

    if (localUser.value != null) {
      await ApiUser.logout();
    }

    Get.snackbar("Success", "Logout successful");
  }

  bool get isLoggedIn => firebaseUser.value != null || localUser.value != null;
}
