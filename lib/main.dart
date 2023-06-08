import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import 'src/global/app_middleware.dart';
import 'src/global/app_reducer.dart';
import 'src/global/app_state.dart';
import 'src/global/di.dart';
import 'src/pop_app.dart';

void main() => runZonedGuarded<void>(
      () {
        WidgetsFlutterBinding.ensureInitialized();
        final store = Store<AppState>(
          appReducer,
          initialState: AppState.init(),
          middleware: createAppMiddleware(DI()),
        );

        runApp(PopApp(store: store));
      },
      (error, stack) => log('Top level exception $error'),
    );
