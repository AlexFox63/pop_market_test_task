// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'predictions_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PredictionsResponse _$PredictionsResponseFromJson(Map<String, dynamic> json) =>
    PredictionsResponse(
      predictions: (json['predictions'] as List<dynamic>)
          .map((e) => Prediction.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$PredictionsResponseToJson(
        PredictionsResponse instance) =>
    <String, dynamic>{
      'predictions': instance.predictions.map((e) => e.toJson()).toList(),
      'status': instance.status,
    };
