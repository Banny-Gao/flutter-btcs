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
  // ignore: top_level_function_literal_block
  '/order': (context) {
    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;

    return Order(orderNumber: args['orderNumber']);
  },
  '/withdraws': (context) => Withdraws(),
  // ignore: top_level_function_literal_block
  '/changePassword': (context) {
    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    final phone = args != null ? args['phone'] : null;
    return ChangePassword(phone: phone);
  },
  // ignore: top_level_function_literal_block
  '/changePhone': (context) {
    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    final mode = args != null ? args['mode'] : 0;
    return ChangePhone(mode: mode);
  },
  // ignore: top_level_function_literal_block
  '/auth': (context) {
    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;

    return Auth(shouldGetAuthInfo: args['shouldGetAuthInfo']);
  },
  // ignore: top_level_function_literal_block
  '/group': (context) {
    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;

    return Group(id: args['id']);
  },
};

class GlobalRoute {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get navigatorState => GlobalRoute.navigatorKey.currentState;
  BuildContext get currentContext => GlobalRoute.navigatorKey.currentContext;
}

RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
