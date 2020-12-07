import 'package:flutter/material.dart';

class RouterModel {
  BuildContext _context;

  initRouter(BuildContext context) {
    _context = context;

    print('-------$_context');
  }

  push(routeTo, {BuildContext context}) {
    final _c = context != null ? context : _context;
    Navigator.push(
      _c,
      routeTo(_c),
    );
  }

  pushNamed({BuildContext context, routeName, arguments = const {}}) {
    Navigator.pushNamed(
      context != null ? context : _context,
      routeName,
      arguments: arguments,
    );
  }

  pushReplacementNamed(
    BuildContext context,
    String routeName, {
    result = const {},
    arguments = const {},
  }) {
    Navigator.pushReplacementNamed(
      context != null ? context : _context,
      routeName,
      result: result,
      arguments: arguments,
    );
  }
}
