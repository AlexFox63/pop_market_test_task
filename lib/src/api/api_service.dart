import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/remote/geocoding_api_response.dart';
import '../models/remote/place_api_response.dart';
import '../models/remote/predictions_response.dart';

part 'api_service.g.dart';

const String apiKey = 'AIzaSyAY_0_HLEixyxX9BBqOTZYmXVEJ3wROO_U';

@RestApi()
abstract class AppApiService {
  factory AppApiService(Dio dio, {String? baseUrl}) = _AppApiService;
}

@RestApi(baseUrl: 'https://maps.googleapis.com/')
abstract class GeolocationService extends AppApiService {
  factory GeolocationService(Dio dio, {String? baseUrl}) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        options.queryParameters['key'] = apiKey;
        return handler.next(options);
      },
    ));
    return _GeolocationService(dio, baseUrl: baseUrl);
  }

  @GET('/maps/api/place/autocomplete/json')
  Future<PredictionsResponse> getGeoPredictions(
    @Query('input') String input,
  );

  @GET('/maps/api/geocode/json')
  Future<GeocodingApiResponse> getAddress({
    @Query('latlng') String? latlng,
    @Query('address') String? address,
  });

  @GET('/maps/api/place/details/json')
  Future<PlaceApiResponse> getPlaceDetails(
    @Query('place_id') String placeId,
  );
}
