import '../features/details/details_reducer.dart';
import '../features/search/search_reducer.dart';
import 'app_state.dart';

AppState appReducer(AppState state, dynamic action) {
  return state.copyWith(
    searchState: searchReducer(state.searchState, action),
    detailsState: detailsReducer(state.detailsState, action),
  );
}
