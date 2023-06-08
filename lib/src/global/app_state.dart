import '../features/details/details_state.dart';
import '../features/search/search_state.dart';

final class AppState {
  final SearchState searchState;
  final DetailsState detailsState;

  AppState.init()
      : searchState = SearchState(),
        detailsState = DetailsState();

  AppState({
    required this.searchState,
    required this.detailsState,
  });

  AppState copyWith({
    SearchState? searchState,
    DetailsState? detailsState,
  }) {
    return AppState(
      searchState: searchState ?? this.searchState,
      detailsState: detailsState ?? this.detailsState,
    );
  }
}
