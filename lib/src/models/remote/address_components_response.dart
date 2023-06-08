import 'package:json_annotation/json_annotation.dart';

import '../local/address_component.dart';
import '../local/geometry.dart';

part 'address_components_response.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class AddressComponentsResponse {
  final List<AddressComponent>? addressComponents;
  final Geometry? geometry;
  final String? status;

  AddressComponentsResponse(
      {required this.addressComponents, required this.geometry, required this.status});

  factory AddressComponentsResponse.fromJson(Map<String, dynamic> json) =>
      _$AddressComponentsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddressComponentsResponseToJson(this);
}
