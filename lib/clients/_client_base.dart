import 'package:dio/dio.dart';

class ClientBase {
  Dio dio;

  static final ClientBase _singleton = ClientBase._internal();

  factory ClientBase() {
    return _singleton;
  }

  ClientBase._internal() : dio = Dio(options);
}

const baseUrl = 'https://api.itbook.store/1.0';

final options = BaseOptions(
  baseUrl: baseUrl,
  connectTimeout: 5000,
  receiveTimeout: 3000,
  followRedirects: false,
  validateStatus: (status) => true,
  headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  },
);
