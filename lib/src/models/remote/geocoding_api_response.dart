import 'package:json_annotation/json_annotation.dart';

import 'address_components_response.dart';

part 'geocoding_api_response.g.dart';

@JsonSerializable()
class GeocodingApiResponse {
  final String? status;
  final List<AddressComponentsResponse>? results;

  GeocodingApiResponse({required this.status, required this.results});

  factory GeocodingApiResponse.fromJson(Map<String, dynamic> json) =>
      _$GeocodingApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GeocodingApiResponseToJson(this);
}
