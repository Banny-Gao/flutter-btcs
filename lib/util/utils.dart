import 'package:url_launcher/url_launcher.dart';

enum LoadingState { DONE, LOADING, WAITING, ERROR }

String concatListToString(List<dynamic> data, String mapKey) {
  StringBuffer buffer = StringBuffer();
  buffer.writeAll(data.map<String>((map) => map[mapKey]).toList(), ", ");
  return buffer.toString();
}

// 原生拨打电话
launchUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  }
}
