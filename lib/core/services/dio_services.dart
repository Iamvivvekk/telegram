import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telegram/core/constants/shared_preferences_keys.dart';

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
              final authorization = prefs.getString(SharedPreferencesKeys.uid);
              log(authorization ?? "Noo token");

              options.headers['Content-Type'] =
                  'application/json; charset=UTF-8';
              options.headers['Accept'] = 'application/json';

              if (authorization != null && authorization.isNotEmpty) {
                options.headers['authorization'] = authorization;
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
