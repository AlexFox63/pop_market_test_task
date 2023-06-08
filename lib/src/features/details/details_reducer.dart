import 'package:redux/redux.dart';

import 'details_actions.dart';
import 'details_state.dart';

final detailsReducer = combineReducers<DetailsState>([
  TypedReducer<DetailsState, DetailsSetInitialLatLngAction>(_setInitialLatLng),
  TypedReducer<DetailsState, DetailsSetFieldsAction>(_setFields),
  TypedReducer<DetailsState, DetailsUpdateLatLngWithoutFieldChangeAction>(_updateLocation),
]);

DetailsState _setInitialLatLng(DetailsState state, DetailsSetInitialLatLngAction action) {
  return state.copyWith(loading: true);
}

DetailsState _setFields(DetailsState state, DetailsSetFieldsAction action) {
  final addressFieldsData = action.addressFields;
  return state.copyWith(
    street: addressFieldsData.street,
    houseNumber: addressFieldsData.houseNumber,
    city: addressFieldsData.city,
    postcode: addressFieldsData.postcode,
    location: action.location,
  );
}

DetailsState _updateLocation(
  DetailsState state,
  DetailsUpdateLatLngWithoutFieldChangeAction action,
) {
  return state.copyWith(location: action.location);
}
