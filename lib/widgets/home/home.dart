import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

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
            padding: EdgeInsets.all(5.0),
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
        viewportFraction: 0.86,
        scale: 0.92,
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
          buildTitle('BTC行情价格'),
          _fireCoins.length != 0
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 20.0,
                      height: 200.0,
                      child: Echarts(
                        option: ''' 
                        {
                          dataset: {
                            dimensions: ['varCreateTime', 'lastPrice'],
                            source: ${jsonEncode(_fireCoins)},
                          },
                          tooltip: {
                              trigger: 'axis',
                              formatter: function (params) {
                                  var data = params[0].value
                                  return data.varCreateTime + '<br />\$ ' + data.lastPrice
                              }
                          },
                          xAxis: {
                              type: 'category',
                              boundaryGap: false,
                          },
                          yAxis: {
                              type: 'value',
                              scale: true,
                          },
                          grid: {
                            left: '14%',
                            top: 16,
                          },
                          dataZoom: [{
                              type: 'inside',
                              start: 0,
                              end: 100
                          }, {
                              type: 'slider',
                              start: 0,
                              end: 100
                          }],
                          series: [{
                            type: 'line',
                            label: {
                              formatter: '价格: {c}'
                            },
                          }],
                        }
                          ''',
                        captureAllGestures: true,
                      ),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  Widget buildhashrateCharts() {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Container(
        margin: EdgeInsets.only(top: 20.0),
        child: Column(
          children: [
            buildTitle('比特超算矿池算力'),
            _hashRates.length != 0
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 24.0,
                          ),
                          child: Text(
                            'TH/s',
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 200.0,
                          child: Echarts(
                            option: ''' 
                        {
                          dataset: {
                            dimensions: ['varCreateTime', 'hashrate'],
                            source: ${jsonEncode(_hashRates)},
                          },
                          tooltip: {
                              trigger: 'axis',
                              formatter: function (params) {
                                  var data = params[0].value
                                  return data.varCreateTime + '<br />' + data.hashrate + ' TH/s'
                              }
                          },
                          xAxis: {
                              type: 'category',
                              boundaryGap: false,
                          },
                          yAxis: {
                              type: 'value',
                          },
                          grid: {
                            left: '14%',
                            top: 16,
                            bottom: 20,
                          },
                          series: [{
                            type: 'line',
                            symbol: 'none',
                            itemStyle: {
                                color: 'rgb(255, 158, 68)'
                            },
                            areaStyle: {
                                color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                                    offset: 0,
                                    color: 'rgb(255, 158, 68)'
                                }, {
                                    offset: 1,
                                    color: 'rgb(255, 70, 131)'
                                }])
                            },
                          }],
                        }
                          ''',
                          ),
                        ),
                      ])
                : Container(),
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

    if (resp.code == 401) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/login',
        (Route route) => false,
      );
      return;
    }
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

    if (resp.code == 401) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/login',
        (Route route) => false,
      );
      return;
    }
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
