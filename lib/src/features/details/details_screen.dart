import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../global/app_state.dart';
import 'details_actions.dart';
import 'details_state.dart';

class DetailsScreen extends StatefulWidget {
  final LatLng location;

  const DetailsScreen({required this.location});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final TextEditingController houseNumberController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController townController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final Set<Marker> _markers = {};

  GoogleMapController? _mapController;
  bool _isProgrammaticLocationChange = false;

  @override
  void initState() {
    super.initState();

    houseNumberController.addListener(_onHouseNumberChanged);
    streetController.addListener(_onStreetChanged);
    townController.addListener(_onTownChanged);
    postalCodeController.addListener(_onPostalCodeChanged);

    StoreProvider.of<AppState>(context, listen: false)
        .dispatch(DetailsSetInitialLatLngAction(widget.location));
  }

  @override
  void dispose() {
    houseNumberController.removeListener(_onHouseNumberChanged);
    streetController.removeListener(_onStreetChanged);
    townController.removeListener(_onTownChanged);
    postalCodeController.removeListener(_onPostalCodeChanged);

    houseNumberController.dispose();
    streetController.dispose();
    townController.dispose();
    postalCodeController.dispose();

    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _onHouseNumberChanged() {
    if (_isProgrammaticLocationChange) {
      StoreProvider.of<AppState>(context).dispatch(
        DetailsUpdateFieldAction(
          houseNumberController.text,
          AddressFieldsType.houseNumber,
        ),
      );
    }
  }

  void _onStreetChanged() {
    if (_isProgrammaticLocationChange) {
      StoreProvider.of<AppState>(context).dispatch(
        DetailsUpdateFieldAction(
          streetController.text,
          AddressFieldsType.street,
        ),
      );
    }
  }

  void _onTownChanged() {
    if (_isProgrammaticLocationChange) {
      StoreProvider.of<AppState>(context).dispatch(
        DetailsUpdateFieldAction(
          townController.text,
          AddressFieldsType.city,
        ),
      );
    }
  }

  void _onPostalCodeChanged() {
    if (!_isProgrammaticLocationChange) {
      StoreProvider.of<AppState>(context).dispatch(
        DetailsUpdateFieldAction(
          postalCodeController.text,
          AddressFieldsType.postcode,
        ),
      );
    }
  }

  void _changeMapLocation(LatLng location) {
    _isProgrammaticLocationChange = true;
    if (!mounted) return;
    _mapController?.animateCamera(CameraUpdate.newLatLng(location));
    StoreProvider.of<AppState>(context).dispatch(
      DetailsUpdateLocationAction(location: location),
    );
    final marker = Marker(markerId: MarkerId('marker_$location'), position: location);
    _markers
      ..clear()
      ..add(marker);
    _isProgrammaticLocationChange = false;
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromState(store.state.detailsState),
      onWillChange: (oldModel, newModel) {
        if (oldModel?.location != newModel.location) {
          _changeMapLocation(newModel.location ?? widget.location);
          houseNumberController.text = newModel.houseNumber ?? '';
          streetController.text = newModel.street ?? '';
          townController.text = newModel.city ?? '';
          postalCodeController.text = newModel.postalCode ?? '';
        }
      },
      builder: (context, viewModel) {
        return Scaffold(
          appBar: AppBar(
            leading: BackButton(
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            foregroundColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text(
                  'Address Information',
                  style: TextStyle(fontSize: 28),
                ),
                Stack(
                  children: [
                    Container(
                      height: 200,
                      child: GoogleMap(
                        onMapCreated: _onMapCreated,
                        markers: _markers,
                        initialCameraPosition: CameraPosition(
                          target: viewModel.location ?? const LatLng(0, 0),
                          zoom: 14,
                        ),
                        myLocationButtonEnabled: false,
                        myLocationEnabled: false,
                        onTap: _changeMapLocation,
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.blueGrey,
                        ),
                        child: const IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                          onPressed: null,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Address',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 15),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: TextField(
                        controller: streetController,
                        decoration: InputDecoration(
                          labelText: 'Street',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: TextField(
                        controller: houseNumberController,
                        decoration: InputDecoration(
                          labelText: 'House Number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: townController,
                  decoration: InputDecoration(
                    labelText: 'Town',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: postalCodeController,
                  decoration: InputDecoration(
                    labelText: 'Postal Code',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Delivery details',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 15),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Delivery Details',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                const Spacer(),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.symmetric(vertical: 15),
                        ),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.pink),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Confirm Address',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ViewModel extends Equatable {
  final LatLng? location;
  final String? houseNumber;
  final String? street;
  final String? city;
  final String? postalCode;
  final String? error;
  final bool loading;

  const _ViewModel({
    required this.location,
    required this.houseNumber,
    required this.street,
    required this.city,
    required this.postalCode,
    required this.error,
    required this.loading,
  });

  factory _ViewModel.fromState(DetailsState detailsState) {
    return _ViewModel(
      location: detailsState.location,
      houseNumber: detailsState.houseNumber,
      street: detailsState.street,
      city: detailsState.city,
      postalCode: detailsState.postcode,
      error: detailsState.error,
      loading: detailsState.loading,
    );
  }

  @override
  List<Object?> get props => [location, houseNumber, street, city, postalCode, error, loading];
}
