import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../global/app_state.dart';
import '../../models/local/prediction.dart';
import '../../widgets/location_item.dart';
import '../details/details_screen.dart';
import 'search_actions.dart';
import 'search_state.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        foregroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'New address',
              style: TextStyle(
                fontSize: 36,
                color: Colors.black,
              ),
            ),
            Flexible(
              child: SearchBody(),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBody extends StatefulWidget {
  @override
  State<SearchBody> createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_onSearchChanged)
      ..dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    StoreProvider.of<AppState>(context).dispatch(SearchInputAction(_searchController.text));
    if (_searchController.text.isNotEmpty) {
      StoreProvider.of<AppState>(context).dispatch(SearchPerformAction());
    }
  }

  void _onCurrentLocationPressed() {
    StoreProvider.of<AppState>(context).dispatch(SearchCurrentLocationAction());
  }

  void _onLocationSelected(Prediction prediction) {
    StoreProvider.of<AppState>(context).dispatch(SearchGetPredictionLatLng(prediction));
  }

  void _openDetailsScreen(LatLng location) {
    Navigator.of(context).push<MaterialPageRoute>(
      MaterialPageRoute(builder: (context) => DetailsScreen(location: location)),
    );
    StoreProvider.of<AppState>(context).dispatch(SearchResetNavigatorAction());
  }

  void _clearTextField() {
    _searchController.clear();
    StoreProvider.of<AppState>(context).dispatch(SearchResetTextField());
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromState(store.state.searchState),
      builder: (context, viewModel) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            if ((viewModel.currentLocation != null || viewModel.predictionLatLng != null) &&
                viewModel.navigatedToDetails &&
                !viewModel.loading) {
              final location = viewModel.currentLocation ?? viewModel.predictionLatLng;
              _openDetailsScreen(location!);
            }
          },
        );

        return ListView(
          children: <Widget>[
            const SizedBox(height: 15),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                labelStyle: const TextStyle(
                  fontSize: 18,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: viewModel.loading
                    ? Container(
                        padding: const EdgeInsets.all(12),
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : _searchController.text.isNotEmpty
                        ? IconButton(
                            onPressed: _clearTextField,
                            icon: const Icon(
                              Icons.clear,
                            ),
                          )
                        : null,
              ),
            ),
            const SizedBox(height: 10),
            LocationItem(
              iconData: Icons.my_location,
              title: 'Current Location',
              onTap: _onCurrentLocationPressed,
            ),
            if (viewModel.predictions != null && viewModel.predictions!.isNotEmpty) ...[
              const Divider(thickness: 1),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: viewModel.predictions!.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      LocationItem(
                        iconData: Icons.location_on_outlined,
                        title: viewModel.predictions![index].description ?? '',
                        titleStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                        onTap: () => _onLocationSelected(viewModel.predictions![index]),
                      ),
                      if (index != viewModel.predictions!.length - 1)
                        const Divider(
                          thickness: 1,
                        ),
                    ],
                  );
                },
              ),
            ]
          ],
        );
      },
    );
  }
}

class _ViewModel extends Equatable {
  final String input;
  final List<Prediction>? predictions;
  final LatLng? currentLocation;
  final LatLng? predictionLatLng;
  final String? error;
  final bool loading;
  final bool navigatedToDetails;

  const _ViewModel({
    required this.input,
    required this.predictions,
    required this.currentLocation,
    required this.predictionLatLng,
    required this.error,
    required this.loading,
    required this.navigatedToDetails,
  });

  factory _ViewModel.fromState(SearchState searchState) {
    return _ViewModel(
      input: searchState.input,
      predictions: searchState.predictions,
      currentLocation: searchState.currentLocation,
      predictionLatLng: searchState.predictionLatLng,
      error: searchState.error,
      loading: searchState.loading,
      navigatedToDetails: searchState.navigatedToDetails,
    );
  }

  @override
  List<Object?> get props => [
        input,
        predictions,
        currentLocation,
        predictionLatLng,
        error,
        loading,
        navigatedToDetails,
      ];
}
