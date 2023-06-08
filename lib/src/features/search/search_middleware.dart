import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:redux/redux.dart';

import '../../api/api_service.dart';
import '../../global/app_state.dart';
import 'search_actions.dart';

List<Middleware<AppState>> createSearchMiddleware(GeolocationService geolocationService) {
  return [
    TypedMiddleware<AppState, SearchPerformAction>(_getGeoPredictions(geolocationService)),
    TypedMiddleware<AppState, SearchCurrentLocationAction>(_getCurrentLocation()),
    TypedMiddleware<AppState, SearchGetPredictionLatLng>(_getPredictionLatLng(geolocationService)),
  ];
}

Middleware<AppState> _getGeoPredictions(GeolocationService geolocationService) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(action);
    if (action is SearchPerformAction) {
      try {
        final response = await geolocationService.getGeoPredictions(store.state.searchState.input);
        store.dispatch(SearchSuccessAction(response.predictions));
      } on Object catch (e) {
        log(e.toString());
        store.dispatch(SearchErrorAction(e.toString()));
      } finally {
        store.dispatch(SearchInputAction(store.state.searchState.input));
      }
    }
  };
}

Middleware<AppState> _getCurrentLocation() {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(action);
    if (action is SearchCurrentLocationAction) {
      try {
        var permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          if (permission != LocationPermission.whileInUse &&
              permission != LocationPermission.always) {
            store.dispatch(SearchErrorAction('Location permissions are denied'));
            return;
          }
        }
        if (!await Geolocator.isLocationServiceEnabled()) {
          store.dispatch(SearchErrorAction('Location services are disabled'));
          return;
        }

        final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        store.dispatch(
          SearchCurrentLocationSuccessAction(
            currentLocation: LatLng(position.latitude, position.longitude),
          ),
        );
      } on Object catch (e) {
        store.dispatch(
          SearchErrorAction(
            'Failed to get current location: $e',
          ),
        );
      }
    }
  };
}

Middleware<AppState> _getPredictionLatLng(GeolocationService geolocationService) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(action);

    if (action is SearchGetPredictionLatLng) {
      try {
        final response = await geolocationService.getPlaceDetails(action.prediction.placeId ?? '');

        if (response.status == 'OK') {
          final lat = response.result?.geometry?.location.lat;
          final lng = response.result?.geometry?.location.lng;

          if (lat != null && lng != null) {
            store.dispatch(
              SearchGetPredictionLatLngSuccessAction(predictionLatLng: LatLng(lat, lng)),
            );
          }
        } else {
          throw Exception('Failed to get LatLng for prediction');
        }
      } on Object catch (e) {
        store.dispatch(SearchErrorAction(e.toString()));
      }
    }
  };
}
