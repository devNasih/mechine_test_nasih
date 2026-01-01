import 'dart:io';
import 'package:dio/dio.dart';
import 'package:mechine_test_nasih/core/network/app_urls.dart';

class ApiClient {
  final Dio dio;
  ApiClient()
    : dio = Dio(
        BaseOptions(
          baseUrl: AppUrls.apiBaseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      ) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (!options.path.contains('/v1/users/signin')) {
            // String token = await authLocalDatasource.getAccessToken() ?? "";
            // log(token);
            // if (token.isNotEmpty) {
            //   options.headers['Authorization'] = 'Bearer $token';
            // }
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.type == DioExceptionType.connectionTimeout ||
              error.type == DioExceptionType.receiveTimeout ||
              error.type == DioExceptionType.sendTimeout) {
            return handler.reject(
              DioException(
                requestOptions: error.requestOptions,
                error: 'Connection timeout. Please check your internet.',
                type: DioExceptionType.connectionTimeout,
              ),
            );
          }

          if (error.error is SocketException ||
              error.type == DioExceptionType.connectionError) {
            return handler.reject(
              DioException(
                requestOptions: error.requestOptions,
                error: 'No internet connection',
                type: DioExceptionType.connectionError,
              ),
            );
          }

          if (error.response != null) {
            final statusCode = error.response!.statusCode;
            if (statusCode == 401) {
              // await authLocalDatasource.clearAuthOnly();
              // NavigationService.navigatorKey.currentState?.pushAndRemoveUntil(
              //   MaterialPageRoute(builder: (_) => const LoginPage()),
              //   (route) => false,
              // );
              return handler.reject(
                DioException(
                  requestOptions: error.requestOptions,
                  error: 'Session expired. Please login again.',
                  response: error.response,
                  type: error.type,
                ),
              );
            } else if (statusCode == 500) {
              return handler.reject(
                DioException(
                  requestOptions: error.requestOptions,
                  error: 'Server error. Please try again later.',
                  response: error.response,
                  type: error.type,
                ),
              );
            }
          }

          return handler.next(error);
        },
      ),
    );
  }
}
