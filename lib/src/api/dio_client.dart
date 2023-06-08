import 'dart:developer';

import 'package:dio/dio.dart';

final class DioConfig {
  static const timeoutDefault = Duration(seconds: 15);

  static Dio configureDioClient() {
    return Dio()
      ..options.responseType = ResponseType.json
      ..options.sendTimeout = timeoutDefault
      ..options.receiveTimeout = timeoutDefault
      ..options.connectTimeout = timeoutDefault
      ..interceptors.add(NetworkLogInterceptor());
  }
}

class NetworkLogInterceptor extends Interceptor {
  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    log('REQUEST: ${options.method} ${options.uri}');
    handler.next(options);
  }

  @override
  Future onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    log(
      'RESPONSE: ${response.statusCode} ${response.requestOptions.method} ${response.requestOptions.uri}',
    );
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.type == DioErrorType.connectionTimeout ||
        err.type == DioErrorType.sendTimeout ||
        err.type == DioErrorType.receiveTimeout) {
      // Handle timeouts
      log(
        'Request timeout',
        error: err,
        stackTrace: err.stackTrace,
      );
    } else if (err.type == DioErrorType.badResponse) {
      // Handle HTTP errors
      log(
        'HTTP error: ${err.response?.statusCode}',
        error: err,
        stackTrace: err.stackTrace,
      );
    } else if (err.type == DioErrorType.cancel) {
      // Handle request cancellation
      log(
        'Request canceled',
        error: err,
        stackTrace: err.stackTrace,
      );
    } else {
      // Handle other errors (e.g., network errors)
      log(
        'Network error',
        error: err,
        stackTrace: err.stackTrace,
      );
    }
    handler.next(err);
  }
}
