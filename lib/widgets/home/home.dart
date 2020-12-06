import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:graphic/graphic.dart' as graphic;

import '../data.dart';

import '../../scopedModels/index.dart';
import '../../models/index.dart' as Models;
import '../../util/index.dart' as Utils;

class Home extends StatefulWidget {
  Home({Key, key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Models.Slides> _imgList = [];
  List<Models.Bulletins> _bulletins = [];

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

    Future.delayed(Duration.zero).then((value) {
      _getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(builder: (context, child, model) {
      return ListView(
        children: <Widget>[
          buildBanners(),
          buildBulletins(),
          buildCharts(),
        ],
      );
    });
  }

  Widget buildBanners() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      height: 200.0,
      child: new Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(
              top: 10.0,
              bottom: 10.0,
              left: 20.0,
              right: 20.0,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black87,
                    offset: Offset(0.0, 4.0),
                    blurRadius: 6.0,
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: new Image.network(
                  "${_imgList[index].imageUrl}",
                  fit: BoxFit.fill,
                ),
              ),
            ),
          );
        },
        key: UniqueKey(),
        itemCount: _imgList.length,
        // pagination: new SwiperPagination(),
        autoplay: true,
        autoplayDelay: 5000,
        // viewportFraction: 0.84,
        // scale: 0.9,
      ),
    );
  }

  Widget buildBulletins() {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      height: 40.0,
      child: Padding(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              FontAwesomeIcons.bullhorn,
              color: Colors.red[400],
              size: 16.0,
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(left: 12),
                child: new Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              _bulletins[index].title,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Icon(
                              FontAwesomeIcons.chevronRight,
                              size: 16.0,
                              color: Colors.grey[400],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  key: UniqueKey(),
                  itemCount: _bulletins.length,
                  autoplay: true,
                  autoplayDelay: 10000,
                  scrollDirection: Axis.vertical,
                  onTap: (index) {
                    _getBulletin(_bulletins[index]);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildCharts() {
    return Container(
      width: 350,
      height: 300,
      child: graphic.Chart(
        data: lineData,
        scales: {
          'Date': graphic.CatScale(
            accessor: (map) => map['Date'] as String,
            range: [0, 1],
            tickCount: 5,
          ),
          'Close': graphic.LinearScale(
            accessor: (map) => map['Close'] as num,
            nice: true,
            min: 100,
          )
        },
        geoms: [
          graphic.LineGeom(
            position: graphic.PositionAttr(field: 'Date*Close'),
            shape: graphic.ShapeAttr(
                values: [graphic.BasicLineShape(smooth: true)]),
            size: graphic.SizeAttr(values: [0.5]),
          ),
        ],
        axes: {
          'Date': graphic.Defaults.horizontalAxis,
          'Close': graphic.Defaults.verticalAxis,
        },
      ),
    );
  }

  @override
  void dispose() {
    EasyLoading.dismiss();
    super.dispose();
  }

  _getData() async {
    EasyLoading.show();
    try {
      await _getSlides();
      await _getBulletins();
    } finally {
      EasyLoading.dismiss();
    }
  }

  _getSlides() async {
    final response = await Utils.API.getSlides();

    final resp = Models.SlidesResponse.fromJson(response);

    if (resp.code != 200) return;

    setState(() {
      _imgList = resp.data.list;
    });
  }

  _getBulletins() async {
    final response = await Utils.API.getBulletins();
    final resp = Models.BulletinsResponse.fromJson(response);

    if (resp.code != 200) return;

    setState(() {
      _bulletins = resp.data?.list;
    });
  }

  _getBulletin(Models.Bulletins bullet) {
    final html = '''
              <!DOCTYPE html>
              <html lang="en">
              <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>${bullet.title}</title>
              </head>
              <body>
                ${bullet.content}
              </body>
              </html>
        ''';
    final String contentBase64 =
        base64Encode(const Utf8Encoder().convert(html));
    print(bullet.title);

    Navigator.push<void>(
      context,
      new MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => WebView(
          initialUrl: 'data:text/html;base64,${contentBase64}',
          gestureNavigationEnabled: true,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
