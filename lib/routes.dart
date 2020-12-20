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
  '/helpClassifications': (context) => HelpClassifications(),
  // ignore: top_level_function_literal_block
  '/helps': (context) {
    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;

    return Helps(id: args['id'], title: args['title']);
  },
  '/walletAddresses': (context) => WalletAddresses(),
  // ignore: top_level_function_literal_block
  '/orderPayment': (context) {
    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;

    return OrderPayment(orderNumber: args['orderNumber']);
  },
  '/orders': (context) => Orders(),
};

class GlobalRoute {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get navigatorState => GlobalRoute.navigatorKey.currentState;
  BuildContext get currentContext => GlobalRoute.navigatorKey.currentContext;
}
