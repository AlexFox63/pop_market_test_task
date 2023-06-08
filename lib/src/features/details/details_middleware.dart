import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:redux/redux.dart';
import '../../api/api_service.dart';
import '../../global/app_state.dart';
import '../../models/local/address_component.dart';
import 'details_actions.dart';

List<Middleware<AppState>> createDetailsMiddleware(GeolocationService geolocationService) {
  return [
    TypedMiddleware<AppState, DetailsSetInitialLatLngAction>(_setInitialLatLng(geolocationService)),
    TypedMiddleware<AppState, DetailsUpdateLocationAction>(
      _updateLocation(geolocationService),
    ),
    TypedMiddleware<AppState, DetailsUpdateFieldAction>(
      _updateField(geolocationService),
    ),
  ];
}

Middleware<AppState> _setInitialLatLng(GeolocationService geolocationService) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(action);

    if (action is DetailsSetInitialLatLngAction) {
      try {
        final response = await geolocationService.getAddress(
          latlng: '${action.location.latitude},${action.location.longitude}',
        );

        if (response.results?.first.addressComponents != null) {
          final components = response.results?.first.addressComponents;
          final fields = parseAddressFields(components!);
          store.dispatch(
            DetailsSetFieldsAction(
              addressFields: fields,
              location: action.location,
            ),
          );
        } else {
          throw Exception('Error during getting address!');
        }
      } on Object catch (e) {
        store.dispatch(DetailsErrorAction(e.toString()));
      }
    }
  };
}

Middleware<AppState> _updateLocation(GeolocationService geolocationService) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(action);

    if (action is DetailsUpdateLocationAction) {
      try {
        final response = await geolocationService.getAddress(
          latlng: '${action.location.latitude},${action.location.longitude}',
        );

        if (response.results?.first.addressComponents != null) {
          final components = response.results?.first.addressComponents;
          final fields = parseAddressFields(components!);
          store.dispatch(
            DetailsSetFieldsAction(
              addressFields: fields,
              location: action.location,
            ),
          );
        } else {
          throw Exception('Error during getting address!');
        }
      } on Object catch (e) {
        store.dispatch(DetailsErrorAction(e.toString()));
      }
    }
  };
}

Middleware<AppState> _updateField(GeolocationService geolocationService) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(action);

    if (action is DetailsUpdateFieldAction) {
      try {
        final state = store.state.detailsState;

        final fullAddress = switch (action.field) {
          AddressFieldsType.street =>
            '${action.value} ${state.houseNumber}, ${state.city}, ${state.postcode}',
          AddressFieldsType.houseNumber =>
            '${state.street} ${action.value}, ${state.city}, ${state.postcode}',
          AddressFieldsType.city =>
            '${state.street} ${state.houseNumber}, ${action.value}, ${state.postcode}',
          AddressFieldsType.postcode =>
            '${state.street} ${state.houseNumber}, ${state.city}, ${action.value}',
        };

        final response = await geolocationService.getAddress(address: fullAddress);

        final newLocation = response.results?.first.geometry?.location;

        if (newLocation != null) {
          store.dispatch(
            DetailsUpdateLatLngWithoutFieldChangeAction(
              LatLng(newLocation.lat, newLocation.lng),
            ),
          );
        } else {
          throw Exception('Error while getting location based on the address');
        }
      } on Object catch (e) {
        store.dispatch(DetailsErrorAction(e.toString()));
      }
    }
  };
}

AddressFields parseAddressFields(List<AddressComponent> components) {
  String? houseNumber, street, city, postcode;

  for (final component in components) {
    if (component.types != null) {
      if (component.types!.contains('street_number')) {
        houseNumber = component.longName;
      } else if (component.types!.contains('route')) {
        street = component.longName;
      } else if (component.types!.contains('locality')) {
        city = component.longName;
      } else if (component.types!.contains('postal_code')) {
        postcode = component.longName;
      }
    }
  }

  return (
    houseNumber: houseNumber ?? '',
    street: street ?? '',
    city: city ?? '',
    postcode: postcode ?? ''
  );
}
