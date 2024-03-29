import 'dart:convert';
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

String constructTime(int seconds, {d = '天', h = '小时', m = '分', s = '秒'}) {
  int day = seconds ~/ 3600 ~/ 24;
  int hour = seconds ~/ 3600 % 24;
  int minute = seconds % 3600 ~/ 60;
  int second = seconds % 60;
  return formatTime(day, d) +
      formatTime(hour, h, day != 0) +
      formatTime(minute, m, day != 0 || hour != 0) +
      formatTime(second, s, day != 0 || hour != 0 || minute != 0);
}

String formatTime(int timeNum, String unit, [bool showUnit = false]) =>
    timeNum != 0 || showUnit ? timeNum.toString() + unit : '';

String getHtmlUrl(title, content, {parsed = true}) {
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
  final String contentBase64 = base64Encode(const Utf8Encoder().convert(html));
  return parsed ? 'data:text/html;base64,${contentBase64}' : html;
}
