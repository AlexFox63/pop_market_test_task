// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceApiResponse _$PlaceApiResponseFromJson(Map<String, dynamic> json) =>
    PlaceApiResponse(
      status: json['status'] as String?,
      result: json['result'] == null
          ? null
          : AddressComponentsResponse.fromJson(
              json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlaceApiResponseToJson(PlaceApiResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'result': instance.result,
    };
