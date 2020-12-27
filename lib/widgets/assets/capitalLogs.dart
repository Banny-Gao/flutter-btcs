import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphic/graphic.dart' as graphic;

import '../../scopedModels/index.dart';
import '../../models/index.dart' as Models;
import '../../util/index.dart' as Utils;

// ignore: must_be_immutable
class CapitalLogs extends StatefulWidget {
  num currencyId;
  CapitalLogs({Key key, @required this.currencyId}) : super(key: key);

  @override
  _CapitalLogs createState() => _CapitalLogs();
}

class _CapitalLogs extends State<CapitalLogs> {
  final num pageSize = 100;
  num pageNum = 1;
  bool isCompleted = false;
  bool isLoading = false;

  List<Models.CapitalLog> logs = [];

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      _getData();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !isCompleted) {
        pageNum++;
        _getData();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (context, child, model) => Scaffold(
        appBar: AppBar(
          title: Text('币种资产明细'),
        ),
        body: Column(
          children: [
            logs.length != 0
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200.0,
                    child: graphic.Chart(
                      data: logs,
                      scales: {
                        'createTime': graphic.CatScale(
                          accessor: (map) => map.createTime.toString(),
                          tickCount: logs.length > 4 ? 4 : logs.length,
                        ),
                        'money': graphic.LinearScale(
                          accessor: (map) => map.money as num,
                          nice: true,
                        ),
                        'type': graphic.CatScale(
                          accessor: (map) => map.type.toString(),
                        ),
                      },
                      geoms: [
                        graphic.LineGeom(
                          position:
                              graphic.PositionAttr(field: 'createTime*money'),
                          color: graphic.ColorAttr(field: 'type'),
                          shape: graphic.ShapeAttr(
                              values: [graphic.BasicLineShape(smooth: true)]),
                        )
                      ],
                      axes: {
                        'createTime': graphic.Defaults.horizontalAxis,
                        'money': graphic.Defaults.verticalAxis,
                      },
                      interactions: [
                        graphic.Defaults.xPaning,
                        graphic.Defaults.xScaling,
                      ],
                    ),
                  )
                : Container(),
            Divider(),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 6.0),
                    child: Icon(
                      FontAwesomeIcons.gripVertical,
                      size: 16.0,
                      color: Colors.red[400],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '资产明细',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  _refreshAddresses();
                },
                child: ListView.custom(
                  controller: _scrollController,
                  itemExtent: 112.0,
                  childrenDelegate: SliverChildBuilderDelegate(
                    (BuildContext context, index) =>
                        buildListItem(model, index),
                    childCount: logs.length + 1,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildListItem(model, index) {
    if (index == logs.length) {
      return isCompleted
          ? Container(
              height: 50.0,
              alignment: Alignment.center,
              padding: EdgeInsets.all(16.0),
              child: Text(
                logs.length == 0
                    ? "暂无数据"
                    : logs.length * 120 > MediaQuery.of(context).size.height
                        ? "没有更多了"
                        : '',
                style: TextStyle(color: Colors.grey),
              ),
            )
          : Container();
    }

    final log = logs[index];

    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 6.0, 10.0, 6.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF2F2FF),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Row(
            children: [
              log.currencyIconPath != null
                  ? Image.network(
                      log.currencyIconPath,
                      width: 24.0,
                      height: 24.0,
                      fit: BoxFit.fill,
                    )
                  : Icon(
                      log.type == 1
                          ? FontAwesomeIcons.wallet
                          : FontAwesomeIcons.exchangeAlt,
                      color: Colors.red[200],
                    ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: Text(
                              Utils.AessetTypes[log.type - 1],
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: log.logStatus == 1
                                  ? Colors.yellow[50]
                                  : Colors.red[50],
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 4.0,
                                horizontal: 10.0,
                              ),
                              child: Text(
                                log.logStatus == 1 ? '支出' : '收入',
                                style: TextStyle(
                                  fontSize: 10.0,
                                  color: log.logStatus == 1
                                      ? Colors.yellow[800]
                                      : Colors.red[400],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        log.createTime,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text('${log.money}'),
            ],
          ),
        ),
      ),
    );
  }

  _refreshAddresses() {
    pageNum = 1;
    logs = [];
    _getData();
  }

  _getData() async {
    EasyLoading.show();
    try {
      await getCapitalLogs();
    } finally {
      EasyLoading.dismiss();
    }
  }

  getCapitalLogs() async {
    final response = await Utils.API.getCapitalLogs(
      pageNum: pageNum,
      pageSize: pageSize,
      currencyId: widget.currencyId,
    );
    final resp = Models.CapitalLogsResponse.fromJson(response);

    if (resp.code != 200) return;
    bool isLastPage = resp.data.isLastPage;

    List<Models.CapitalLog> list = resp.data.list;
    Iterable<Models.CapitalLog> more = logs.followedBy(list);
    if (mounted)
      setState(() {
        logs = more.toList();
        isCompleted = isLastPage;
        logs.sort((left, right) => left.createTime.compareTo(right.createTime));
      });
  }
}
