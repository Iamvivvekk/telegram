import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/api_constants.dart';

final dioServiceProvider = Provider<Dio>((ref) {
  final dio = Dio();
  final handler = DioServices(dio: dio);
  handler._configDio();
  handler._interceptors();
  return handler._dio;
});

class DioServices {
  final Dio _dio;

  DioServices({required Dio dio}) : _dio = dio;

  void _configDio() {
    _dio.options.baseUrl = ApiConstants.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 60);
    _dio.options.receiveTimeout = const Duration(seconds: 60);
  }

  void _interceptors() {
    _dio.interceptors.add(
      LogInterceptor(request: true, requestHeader: true, responseBody: true),
    );
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
              final prefs = await SharedPreferences.getInstance();
              final token = prefs.getString('authToken');

              options.headers['Content-Type'] =
                  'application/json; charset=UTF-8';
              options.headers['Accept'] = 'application/json';

              if (token != null && token.isNotEmpty) {
                options.headers['Authorization'] = 'Bearer $token';
              }
              return handler.next(options);
            },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          return handler.next(response);
        },
        onError: (exception, handler) {
          if (exception.response!.statusCode == 404) {
            return handler.next(exception);
          }
        },
      ),
    );
  }
}
