import 'dart:io';

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
import '../../routes.dart';

class Home extends StatefulWidget {
  Home({Key, key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  List<Models.Slides> _imgList = [];
  List<Models.Bulletins> _bulletins = [];

  get wantKeepAlive => true;

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
          buildCoinPirceCharts(),
          buildhashrateCharts(),
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
            padding: EdgeInsets.all(10.0),
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
        viewportFraction: 0.80,
        scale: 0.84,
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
              color: Theme.of(context).primaryColor,
              size: 12.0,
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
                                fontSize: 14.0,
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

  Widget buildTitle(title) {
    return Text(
      title,
      style: TextStyle(
        color: Theme.of(context).hintColor,
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget buildCoinPirceCharts() {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            buildTitle('FireCoin价格'),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 240.0,
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
            ),
          ],
        ),
      ),
    );
  }

  Widget buildhashrateCharts() {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            buildTitle('矿池算力'),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 240.0,
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
            ),
          ],
        ),
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
    final Map<String, String> arguments = {
      'title': bullet.title,
      'content': bullet.content,
    };
    Navigator.of(GlobalRoute.navigatorKey.currentContext).pushNamed(
      '/contentPreview',
      arguments: arguments,
    );
  }
}
