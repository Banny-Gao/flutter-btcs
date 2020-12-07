import 'package:flutter/material.dart';

import './widgets/index.dart';
import './app.dart';

final routes = {
  '/': (context) => App(),
  '/login': (context) => Login(),
  '/groupBooking': (context) => GroupBooking(),
  '/owner': (context) => Owner(),
  // ignore: top_level_function_literal_block
  '/contentPreview': (context) {
    final Map<String, String> args = ModalRoute.of(context).settings.arguments;

    return ContentPreview(title: args['title'], content: args['content']);
  },
};
