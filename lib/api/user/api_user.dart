import 'package:dio/dio.dart';
import 'package:dompetly/api/api.dart';
import 'package:dompetly/api/base_response.dart';
import 'package:dompetly/api/user/request/user_request.dart';
import 'package:dompetly/controllers/auth_controller.dart';
import 'package:dompetly/models/local_user.dart';

class ApiUser {
  static final authController = AuthController.to;

  static Future<BaseResponse<LocalUser?>> login({
    required UserRequest request,
  }) async {
    final response = await Api.instance.post(
      '/auth/login',
      data: request.toJsonLogin(),
    );

    if (response.statusCode == 200) {
      return BaseResponse(
        success: true,
        data: LocalUser.fromJson(response.data['data']),
        message: response.data['message'],
      );
    } else {
      return BaseResponse.fromJson(response.data);
    }
  }

  static Future<BaseResponse<LocalUser?>> register({
    required UserRequest request,
  }) async {
    final response = await Api.instance.post(
      '/auth/register',
      data: request.toJsonRegister(),
    );

    if (response.statusCode == 200) {
      return BaseResponse(
        success: true,
        data: LocalUser.fromJson(response.data['data']),
        message: response.data['message'],
      );
    } else {
      return BaseResponse.fromJson(response.data);
    }
  }

  static Future<void> logout() async {
    if (authController.localUser.value == null) {
      return;
    }

    final response = await Api.instance.post(
      '/logout',
      options: Options(
        headers: {
          'Authorization': 'Bearer ${authController.localUser.value?.token}',
        },
      ),
    );

    if (response.statusCode == 200) {
      BaseResponse baseResponse = BaseResponse.fromJson(response.data);
      if (baseResponse.success) {
        authController.localUser.value = null;
      }
    }
  }
}
