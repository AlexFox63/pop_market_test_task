import 'package:redux/redux.dart';
import '../features/details/details_middleware.dart';
import '../features/search/search_middleware.dart';
import 'app_state.dart';
import 'di.dart';

List<Middleware<AppState>> createAppMiddleware(DI dependencies) {
  return [
    ...createSearchMiddleware(dependencies.geolocationService),
    ...createDetailsMiddleware(dependencies.geolocationService),
  ];
}
