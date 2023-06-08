import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'features/search/search_screen.dart';
import 'global/app_state.dart';

class PopApp extends StatefulWidget {
  const PopApp({
    required this.store,
    Key? key,
  }) : super(key: key);

  final Store<AppState> store;

  @override
  State<PopApp> createState() => _PopAppState();
}

class _PopAppState extends State<PopApp> {
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: widget.store,
      child: MaterialApp(
        title: 'Pop test task',
        home: SearchScreen(),
      ),
    );
  }
}
