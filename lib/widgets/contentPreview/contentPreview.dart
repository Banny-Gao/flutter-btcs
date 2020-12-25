import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../util/utils.dart';

class ContentPreview extends StatelessWidget {
  final String title;
  final String content;
  final String url;

  ContentPreview({Key key, @required this.title, this.content, this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final initialUrl = url != null ? url : getHtmlUrl(title, content);

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
}
