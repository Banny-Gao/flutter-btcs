import 'package:flutter/material.dart';

import './widgets/index.dart';
import './app.dart';

final routes = {
  '/': (context) => App(),
  '/login': (context) => Login(),
  // ignore: top_level_function_literal_block
  '/contentPreview': (context) {
    final Map<String, String> args = ModalRoute.of(context).settings.arguments;

    return ContentPreview(title: args['title'], content: args['content']);
  },
  '/editUser': (context) => EditUser(),
};

class GlobalRoute {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get navigatorState => GlobalRoute.navigatorKey.currentState;
  BuildContext get currentContext => GlobalRoute.navigatorKey.currentContext;
}
