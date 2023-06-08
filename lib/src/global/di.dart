import 'package:dio/dio.dart';

import '../api/api_service.dart';
import '../api/dio_client.dart';

final class DI {
  late final Dio _dio;
  late final GeolocationService _geolocationService;

  static final DI _singleton = DI._internal();

  factory DI() {
    return _singleton;
  }

  DI._internal() {
    _dio = DioConfig.configureDioClient();
    _geolocationService = GeolocationService(_dio);
  }

  GeolocationService get geolocationService => _geolocationService;
}
