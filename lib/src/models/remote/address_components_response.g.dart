// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_components_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressComponentsResponse _$AddressComponentsResponseFromJson(
        Map<String, dynamic> json) =>
    AddressComponentsResponse(
      addressComponents: (json['address_components'] as List<dynamic>?)
          ?.map((e) => AddressComponent.fromJson(e as Map<String, dynamic>))
          .toList(),
      geometry: json['geometry'] == null
          ? null
          : Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$AddressComponentsResponseToJson(
        AddressComponentsResponse instance) =>
    <String, dynamic>{
      'address_components':
          instance.addressComponents?.map((e) => e.toJson()).toList(),
      'geometry': instance.geometry?.toJson(),
      'status': instance.status,
    };
