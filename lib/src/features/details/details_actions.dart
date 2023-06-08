import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../global/app_actions.dart';

enum AddressFieldsType {
  street,
  houseNumber,
  city,
  postcode,
}

typedef AddressFields = ({
  String street,
  String houseNumber,
  String city,
  String postcode,
});

extension AddressFieldsExtension on AddressFields {
  String getString() {
    return '${this.houseNumber} ${this.street}, ${this.city}, ${this.postcode}';
  }
}

abstract base class DetailsAction extends AppAction {}

final class DetailsSetInitialLatLngAction extends DetailsAction {
  final LatLng location;

  DetailsSetInitialLatLngAction(this.location);
}

final class DetailsSetFieldsAction extends DetailsAction {
  final AddressFields addressFields;
  final LatLng location;

  DetailsSetFieldsAction({
    required this.addressFields,
    required this.location,
  });
}

final class DetailsUpdateLocationAction extends DetailsAction {
  final LatLng location;

  DetailsUpdateLocationAction({
    required this.location,
  });
}

final class DetailsUpdateFieldAction extends DetailsAction {
  final String value;
  final AddressFieldsType field;

  DetailsUpdateFieldAction(this.value, this.field);
}

final class DetailsUpdateFieldSuccessAction extends DetailsAction {
  final String value;
  final AddressFieldsType field;

  DetailsUpdateFieldSuccessAction(this.value, this.field);
}

final class DetailsUpdateLatLngWithoutFieldChangeAction extends DetailsAction {
  final LatLng location;

  DetailsUpdateLatLngWithoutFieldChangeAction(this.location);
}

final class DetailsErrorAction extends DetailsAction {
  final String errorMessage;

  DetailsErrorAction(this.errorMessage);
}
