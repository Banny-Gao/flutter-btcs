import 'package:flutter/material.dart';

class Alert {
  static Color _errorFontColor = Colors.red[600];
  static Color _basicBackgroundColor = Colors.grey[200];

  static void error(String errorMessage,
      {BuildContext context, ScaffoldState currentState}) {
    final ScaffoldState c =
        context != null ? Scaffold.of(context) : currentState;

    c.removeCurrentSnackBar();
    c.showSnackBar(SnackBar(
      backgroundColor: _basicBackgroundColor,
      duration: Duration(seconds: 1),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Icon(
              Icons.error,
              color: _errorFontColor,
            ),
          ),
          Text(
            errorMessage,
            style: TextStyle(color: _errorFontColor),
          ),
        ],
      ),
    ));
  }
}
