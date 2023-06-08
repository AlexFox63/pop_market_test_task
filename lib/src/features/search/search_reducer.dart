import 'package:redux/redux.dart';

import 'search_actions.dart';
import 'search_state.dart';

final searchReducer = combineReducers<SearchState>([
  TypedReducer<SearchState, SearchInputAction>(_input),
  TypedReducer<SearchState, SearchPerformAction>(_getPrediction),
  TypedReducer<SearchState, SearchCurrentLocationAction>(_getCurrentLocation),
  TypedReducer<SearchState, SearchGetPredictionLatLng>(_getPredictionLatLng),
  TypedReducer<SearchState, SearchCurrentLocationSuccessAction>(_successGetting),
  TypedReducer<SearchState, SearchGetPredictionLatLngSuccessAction>(_successPredictionLatLng),
  TypedReducer<SearchState, SearchSuccessAction>(_successFinding),
  TypedReducer<SearchState, SearchErrorAction>(_error),
  TypedReducer<SearchState, SearchResetNavigatorAction>(_resetNavigation),
  TypedReducer<SearchState, SearchResetTextField>(_resetTextField),
]);

SearchState _input(SearchState searchState, SearchInputAction action) {
  return searchState.copyWith(input: action.value);
}

SearchState _getPrediction(SearchState searchState, SearchPerformAction action) {
  return searchState.copyWith(loading: true);
}

SearchState _getCurrentLocation(SearchState searchState, SearchCurrentLocationAction action) {
  return searchState.copyWith(loading: true);
}

SearchState _getPredictionLatLng(SearchState searchState, SearchGetPredictionLatLng action) {
  return searchState.copyWith(loading: true);
}

SearchState _successFinding(SearchState searchState, SearchSuccessAction action) {
  return searchState.copyWith(
    loading: false,
    predictions: action.predictions,
  );
}

SearchState _successGetting(SearchState searchState, SearchCurrentLocationSuccessAction action) {
  return searchState.copyWith(
    loading: false,
    currentLocation: action.currentLocation,
    navigatedToDetails: true,
  );
}

SearchState _successPredictionLatLng(
    SearchState searchState, SearchGetPredictionLatLngSuccessAction action) {
  return searchState.copyWith(
    loading: false,
    predictionLatLng: action.predictionLatLng,
    navigatedToDetails: true,
  );
}

SearchState _error(SearchState searchState, SearchErrorAction action) {
  return searchState.copyWith(loading: false, error: action.errorMessage);
}

SearchState _resetNavigation(SearchState searchState, SearchResetNavigatorAction action) {
  return searchState.copyWith(
    currentLocation: null,
    predictionLatLng: null,
    navigatedToDetails: false,
  );
}

SearchState _resetTextField(SearchState searchState, SearchResetTextField action) {
  return searchState.copyWith(predictions: []);
}
