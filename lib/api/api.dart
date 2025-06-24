import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Api {
  static final String _baseUrl =
      dotenv.env["API_URL"] ?? "http://10.0.2.2:8080/api";
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
