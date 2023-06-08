import 'package:json_annotation/json_annotation.dart';

part 'prediction.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
final class Prediction {
  final String? description;
  final String? placeId;
  final List<String?> types;

  Prediction({
    required this.description,
    required this.placeId,
    required this.types,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) => _$PredictionFromJson(json);

  Map<String, dynamic> toJson() => _$PredictionToJson(this);
}
