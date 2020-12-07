import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ContentPreview extends StatelessWidget {
  final String title;
  final String content;
  final String url;

  ContentPreview({Key key, @required this.title, this.content, this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final initialUrl = url != null ? url : _getHtmlUrl(title, content);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Scrollbar(
        child: WebView(
          initialUrl: initialUrl,
          gestureNavigationEnabled: true,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }

  String _getHtmlUrl(title, content) {
    final html = '''
              <!DOCTYPE html>
              <html lang="en">
              <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>${title}</title>
              </head>
              <body>
                ${content}
              </body>
              </html>
        ''';
    final String contentBase64 =
        base64Encode(const Utf8Encoder().convert(html));
    return 'data:text/html;base64,${contentBase64}';
  }
}
