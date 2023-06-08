// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geocoding_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeocodingApiResponse _$GeocodingApiResponseFromJson(
        Map<String, dynamic> json) =>
    GeocodingApiResponse(
      status: json['status'] as String?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) =>
              AddressComponentsResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GeocodingApiResponseToJson(
        GeocodingApiResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'results': instance.results,
    };
