import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphic/graphic.dart' as graphic;

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
  List<Models.HashRate> _hashRates = [];
  List<Models.CoinPrice> _fireCoins = [];

  get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero).then((value) {
      _getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(builder: (context, child, model) {
      return Scaffold(
        appBar: AppBar(
          title: Text('比特超算'),
        ),
        body: ListView(
          children: <Widget>[
            buildBanners(),
            buildBulletins(),
            buildCoinPirceCharts(),
            buildhashrateCharts(),
          ],
        ),
      );
    });
  }

  Widget buildBanners() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      height: 160.0,
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
                child: InkWell(
                  onTap: () {},
                  child: new Image.network(
                    "${_imgList[index].imageUrl}",
                    fit: BoxFit.fill,
                  ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildTitle('公告'),
        Container(
          color: Color(0xFFF2F2FF),
          child: Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Container(
              height: 40.0,
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
          ),
        ),
      ],
    );
  }

  Widget buildTitle(String title, {IconData icon}) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 6.0),
            child: Icon(
              icon != null ? icon : FontAwesomeIcons.gripVertical,
              size: 16.0,
              color: Colors.red[400],
            ),
          ),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCoinPirceCharts() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: [
          buildTitle('FireCoin价格'),
          _fireCoins.length != 0
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200.0,
                  child: graphic.Chart(
                    data: _fireCoins,
                    scales: {
                      'createTime': graphic.CatScale(
                        accessor: (map) => map.createTime.toString(),
                        tickCount:
                            _fireCoins.length > 4 ? 4 : _fireCoins.length,
                      ),
                      'lastPrice': graphic.LinearScale(
                        accessor: (map) => map.lastPrice as num,
                        nice: true,
                      ),
                    },
                    geoms: [
                      graphic.LineGeom(
                        position:
                            graphic.PositionAttr(field: 'createTime*lastPrice'),
                        shape: graphic.ShapeAttr(
                            values: [graphic.BasicLineShape(smooth: true)]),
                        size: graphic.SizeAttr(values: [0.5]),
                        color: graphic.ColorAttr(values: Colors.primaries),
                      )
                    ],
                    axes: {
                      'createTime': graphic.Defaults.horizontalAxis,
                      'lastPrice': graphic.Defaults.verticalAxis,
                    },
                    interactions: [
                      graphic.Defaults.xPaning,
                      graphic.Defaults.xScaling,
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget buildhashrateCharts() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: [
          buildTitle('矿池算力'),
          _hashRates.length != 0
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200.0,
                  child: graphic.Chart(
                    data: _hashRates,
                    scales: {
                      'createTime': graphic.CatScale(
                        accessor: (map) => map.createTime.toString(),
                        tickCount:
                            _hashRates.length > 4 ? 4 : _hashRates.length,
                      ),
                      'hashrate': graphic.LinearScale(
                        accessor: (map) => map.hashrate as num,
                        nice: true,
                      ),
                    },
                    geoms: [
                      graphic.LineGeom(
                        position:
                            graphic.PositionAttr(field: 'createTime*hashrate'),
                        shape: graphic.ShapeAttr(
                            values: [graphic.BasicLineShape(smooth: true)]),
                        size: graphic.SizeAttr(values: [0.5]),
                        color: graphic.ColorAttr(values: Colors.primaries),
                      ),
                      // graphic.AreaGeom(
                      //   position:
                      //       graphic.PositionAttr(field: 'createTime*hashrate'),
                      //   shape: graphic.ShapeAttr(
                      //       values: [graphic.BasicAreaShape(smooth: true)]),
                      //   color: graphic.ColorAttr(
                      //     values: Colors.primaries
                      //         .map<Color>(
                      //           (color) => color.withAlpha(65),
                      //         )
                      //         .toList(),
                      //   ),
                      // ),
                    ],
                    axes: {
                      'createTime': graphic.Defaults.horizontalAxis,
                      'hashrate': graphic.Defaults.verticalAxis,
                    },
                    interactions: [
                      graphic.Defaults.xPaning,
                      graphic.Defaults.xScaling,
                    ],
                  ),
                )
              : Container(),
        ],
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
      _getHashRate();
      _getFireCoins();
    } finally {
      EasyLoading.dismiss();
    }
  }

  _getSlides() async {
    final response = await Utils.API.getSlides();

    final resp = Models.SlidesResponse.fromJson(response);

    if (resp.code != 200) return;

    if (mounted)
      setState(() {
        _imgList = resp.data.list;
      });
  }

  _getBulletins() async {
    final response = await Utils.API.getBulletins();
    final resp = Models.BulletinsResponse.fromJson(response);

    if (resp.code != 200) return;

    if (mounted)
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

  _getHashRate() async {
    final response = await Utils.API.getHashRate();
    final resp = Models.HashRateResponse.fromJson(response);

    if (resp.code != 200) {
      EasyLoading.showError(resp.message);
      return;
    }

    if (mounted)
      setState(() {
        resp.data.sort((left, right) {
          return left.longTime.compareTo(right.longTime);
        });
        _hashRates = resp.data;
      });
  }

  _getFireCoins() async {
    final response = await Utils.API.getCoinPrice();
    final resp = Models.CoinPricesResponse.fromJson(response);

    if (resp.code != 200) {
      EasyLoading.showError(resp.message);
      return;
    }

    if (mounted)
      setState(() {
        resp.data.sort((left, right) {
          return left.longTime.compareTo(right.longTime);
        });
        _fireCoins = resp.data;
      });
  }
}
