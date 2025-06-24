import 'package:dompetly/api/base_response.dart';
import 'package:dompetly/api/user/api_user.dart';
import 'package:dompetly/api/user/request/user_request.dart';
import 'package:dompetly/components/snackbar.dart';
import 'package:dompetly/models/auth_user.dart';
import 'package:dompetly/models/local_user.dart';
import 'package:dompetly/pages/dashboard_page.dart';
import 'package:dompetly/pages/security_pin_page.dart';
import 'package:dompetly/utils/response_util.dart';
import 'package:dompetly/utils/string_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Rxn<AuthUser> authUser = Rxn<AuthUser>();
  final _authBox = GetStorage();
  final _authKey = 'auth_user';

  @override
  void onInit() {
    super.onInit();
    final savedUser = _loadAuthUser();

    authUser.bindStream(
      _firebaseAuth.authStateChanges().map((user) {
        if (user == null) {
          return null;
        }

        return AuthUser.fromFirebaseUser(user).copyWith(
          token: savedUser?.token,
          userId: savedUser?.userId,
          pin: savedUser?.pin,
          loginType: savedUser?.loginType,
        );
      }),
    );
  }

  Future<void> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        _notifyError("Google login cancelled by user");
        return;
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );
      final user = userCredential.user;

      if (user == null) {
        _notifyError("Failed to authenticate with Google");
        return;
      }

      final isNewUser = userCredential.additionalUserInfo?.isNewUser ?? false;

      if (isNewUser) {
        final password = StringUtil.generateRandomPassword(16);
        await _registerToBackend(
          firebaseUser: user,
          username: googleUser.displayName,
          loginType: LoginType.google,
          password: password,
        );
      } else {
        await _loginToBackend(
          firebaseUser: user,
          loginType: LoginType.google,
          password: null,
        );
      }

      Snackbar.show("Google login successful", SnackbarType.success);

      if (authUser.value?.pin == null) {
        Get.offAllNamed('${SecurityPinPage.routeName}?mode=create');
      } else {
        Get.offAllNamed('${SecurityPinPage.routeName}?mode=auth');
      }
    } catch (e) {
      print("Google Sign-In Error: $e");
      _notifyError("There was an error logging in with Google");
    }
  }

  Future<bool> signInWithEmail({required UserRequest request}) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: request.email!,
        password: request.password!,
      );

      final user = result.user;

      if (user?.emailVerified == false) {
        _notifyError(
          "Your account is not activated yet, please check your email",
        );
        return false;
      }

      await _loginToBackend(
        firebaseUser: user!,
        loginType: LoginType.email,
        password: request.password,
      );

      Snackbar.show("Login successful", SnackbarType.success);

      if (authUser.value?.pin == null) {
        Get.offAllNamed('${SecurityPinPage.routeName}?mode=create');
      } else {
        Get.offAllNamed('${SecurityPinPage.routeName}?mode=auth');
      }

      return true;
    } on FirebaseAuthException catch (e) {
      _notifyError(ResponseUtil(code: e.code).responseLogin);
      return false;
    } catch (e) {
      print("Email login error: $e");
      _notifyError("There was an error logging in with Email");
      return false;
    }
  }

  Future<BaseResponse<LocalUser?>> registerWithEmail({
    required UserRequest request,
  }) async {
    try {
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: request.email!,
        password: request.password!,
      );

      final user = result.user;

      if (user == null) {
        return BaseResponse(success: false, message: "Registration failed");
      }

      await user.updateDisplayName(request.username);
      await user.sendEmailVerification();

      return await _registerToBackend(
        firebaseUser: user,
        username: request.username,
        loginType: LoginType.email,
        password: request.password!,
      );
    } on FirebaseAuthException catch (e) {
      return BaseResponse(
        success: false,
        message: ResponseUtil(code: e.code).responseRegister,
      );
    } catch (e) {
      print("Register error: $e");
      return BaseResponse(
        success: false,
        message: "Registration error occurred",
      );
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await GoogleSignIn().signOut();
    authUser.value = null;
    _authBox.remove(_authKey);
  }

  Future<bool> createPin(int pin) async {
    try {
      String pinValue = StringUtil.intToBase64(pin);

      var response = await ApiUser.updatePin(pinValue, pinValue, pinValue);

      if (response.success) {
        authUser.value = authUser.value?.copyWith(pin: pin);

        Snackbar.show("PIN created successfully", SnackbarType.success);

        Future.delayed(
          const Duration(seconds: 1),
          () => Get.offAllNamed(DashboardPage.routeName),
        );

        return true;
      } else {
        _notifyError(response.message ?? "PIN creation failed");
        return false;
      }
    } catch (e) {
      print("PIN creation error: $e");
      _notifyError("There was an error creating your PIN");
      return false;
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      Snackbar.show(
        "Password reset email sent, please check your email to continue",
        SnackbarType.success,
      );
    } catch (e) {
      print("Password reset error: $e");
      _notifyError("There was an error resetting your password");
    }
  }

  bool checkPin(String pin) {
    if (authUser.value?.pin == null) {
      return false;
    }

    return authUser.value?.pin == int.parse(pin);
  }

  Future<BaseResponse<LocalUser?>> _registerToBackend({
    required User firebaseUser,
    required String? username,
    required LoginType loginType,
    required String password,
  }) async {
    final response = await ApiUser.register(
      request: UserRequest(
        firebaseUid: firebaseUser.uid,
        email: firebaseUser.email,
        photoUrl: firebaseUser.photoURL,
        username: username,
        loginType: loginType,
        password: password,
        confirmPassword: password,
      ),
    );

    if (response.success) {
      int? pin = StringUtil.base64ToInt(response.data?.pin);

      authUser.value = AuthUser(
        firebaseUser: firebaseUser,
        userId: response.data?.id,
        token: response.data?.token,
        pin: pin,
        loginType: loginType,
        username: response.data?.username,
      );

      print('authUserValue: ${authUser.value}');

      _saveAuthUser(authUser.value);
    } else {
      await signOut();
      _notifyError(response.message ?? "Registration failed");
    }

    return response;
  }

  Future<void> _loginToBackend({
    required User firebaseUser,
    required LoginType loginType,
    required String? password,
  }) async {
    final response = await ApiUser.login(
      request: UserRequest(
        firebaseUid: firebaseUser.uid,
        email: firebaseUser.email,
        loginType: loginType,
        password: password,
      ),
    );

    if (response.success) {
      int? pin = StringUtil.base64ToInt(response.data?.pin);

      authUser.value = AuthUser(
        firebaseUser: firebaseUser,
        userId: response.data?.id,
        token: response.data?.token,
        pin: pin,
        loginType: loginType,
        username: response.data?.username,
      );

      print('authUserValue: ${authUser.value}');

      _saveAuthUser(authUser.value);
    } else {
      await signOut();
      _notifyError(response.message ?? "Login failed");
    }
  }

  void _notifyError(String message) {
    Snackbar.show(message, SnackbarType.error);
  }

  void _saveAuthUser(AuthUser? authUser) {
    if (authUser == null) {
      return;
    }

    var user = authUser.toJson();

    print('saved user: $user');
    _authBox.write(_authKey, user);
  }

  AuthUser? _loadAuthUser() {
    final authUserJson = _authBox.read(_authKey);
    if (authUserJson != null) {
      var user = AuthUser.fromJson(authUserJson);
      print('loaded user: $user');
      return user;
    }
    return null;
  }

  bool get isLoggedIn => authUser.value?.isLoggedIn ?? false;

  bool get isPinSet => authUser.value?.pin != null;
}
