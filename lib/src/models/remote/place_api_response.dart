import 'package:json_annotation/json_annotation.dart';

import 'address_components_response.dart';

part 'place_api_response.g.dart';

@JsonSerializable()
class PlaceApiResponse {
  final String? status;
  final AddressComponentsResponse? result;

  PlaceApiResponse({required this.status, required this.result});

  factory PlaceApiResponse.fromJson(Map<String, dynamic> json) => _$PlaceApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceApiResponseToJson(this);
}
