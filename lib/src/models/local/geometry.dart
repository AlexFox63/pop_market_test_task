import 'package:json_annotation/json_annotation.dart';

import 'location.dart';

part 'geometry.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Geometry {
  final Location location;

  Geometry({
    required this.location,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) => _$GeometryFromJson(json);

  Map<String, dynamic> toJson() => _$GeometryToJson(this);
}
