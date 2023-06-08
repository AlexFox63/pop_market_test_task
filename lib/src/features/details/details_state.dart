import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailsState {
  final LatLng? location;
  final String? houseNumber;
  final String? street;
  final String? city;
  final String? postcode;
  final String? error;
  final bool loading;

  DetailsState({
    this.loading = false,
    this.location,
    this.houseNumber = '',
    this.street = '',
    this.city = '',
    this.postcode = '',
    this.error,
  });

  DetailsState copyWith({
    String? input,
    bool? loading,
    LatLng? location,
    String? houseNumber,
    String? street,
    String? city,
    String? postcode,
    String? error,
  }) {
    return DetailsState(
      loading: loading ?? this.loading,
      location: location ?? this.location,
      houseNumber: houseNumber ?? this.houseNumber,
      street: street ?? this.street,
      city: city ?? this.city,
      postcode: postcode ?? this.postcode,
      error: error ?? this.error,
    );
  }
}
