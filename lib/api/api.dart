import 'package:dio/dio.dart';

class Api {
  static final String _baseUrl = "http://10.0.2.2:8080/api";
  static final Dio instance = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
      responseType: ResponseType.json,
      contentType: Headers.jsonContentType,
      validateStatus: (status) {
        return status! < 500;
      },
    ),
  );
}
