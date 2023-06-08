import 'package:json_annotation/json_annotation.dart';

import '../local/prediction.dart';

part 'predictions_response.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
final class PredictionsResponse {
  final List<Prediction> predictions;
  final String? status;

  PredictionsResponse({
    required this.predictions,
    required this.status,
  });

  factory PredictionsResponse.fromJson(Map<String, dynamic> json) =>
      _$PredictionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PredictionsResponseToJson(this);
}
