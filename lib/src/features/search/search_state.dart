import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../models/local/prediction.dart';
import 'search_actions.dart';

class SearchState {
  final String input;
  final bool loading;
  final List<Prediction>? predictions;
  final LatLng? currentLocation;
  final LatLng? predictionLatLng;
  final String? error;
  final bool navigatedToDetails;

  SearchState({
    this.input = '',
    this.loading = false,
    this.predictions,
    this.currentLocation,
    this.predictionLatLng,
    this.error,
    this.navigatedToDetails = false,
  });

  SearchState copyWith({
    String? input,
    bool? loading,
    List<Prediction>? predictions,
    LatLng? currentLocation,
    LatLng? predictionLatLng,
    String? error,
    SearchAction? lastAction,
    bool? navigatedToDetails,
  }) {
    return SearchState(
      input: input ?? this.input,
      loading: loading ?? this.loading,
      predictions: predictions ?? this.predictions,
      currentLocation: currentLocation ?? this.currentLocation,
      predictionLatLng: predictionLatLng ?? this.predictionLatLng,
      error: error ?? this.error,
      navigatedToDetails: navigatedToDetails ?? this.navigatedToDetails,
    );
  }
}
