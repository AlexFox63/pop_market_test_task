import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../global/app_actions.dart';
import '../../models/local/prediction.dart';

abstract base class SearchAction extends AppAction {}

final class SearchInputAction extends SearchAction {
  final String value;

  SearchInputAction(this.value);
}

final class SearchPerformAction extends SearchAction {}

final class SearchCurrentLocationAction extends SearchAction {}

final class SearchGetPredictionLatLng extends SearchAction {
  final Prediction prediction;

  SearchGetPredictionLatLng(this.prediction);
}

final class SearchSuccessAction extends SearchAction {
  final List<Prediction> predictions;

  SearchSuccessAction(this.predictions);
}

final class SearchCurrentLocationSuccessAction extends SearchAction {
  final LatLng? currentLocation;

  SearchCurrentLocationSuccessAction({required this.currentLocation});
}

final class SearchGetPredictionLatLngSuccessAction extends SearchAction {
  final LatLng? predictionLatLng;

  SearchGetPredictionLatLngSuccessAction({required this.predictionLatLng});
}

final class SearchErrorAction extends SearchAction {
  final String errorMessage;

  SearchErrorAction(this.errorMessage);
}

final class SearchResetNavigatorAction extends SearchAction {}

final class SearchResetTextField extends SearchAction {}
