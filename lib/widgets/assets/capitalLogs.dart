import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphic/graphic.dart' as graphic;

import '../../scopedModels/index.dart';
import '../../models/index.dart' as Models;
import '../../util/index.dart' as Utils;

import '../data.dart';

// ignore: must_be_immutable
class CapitalLogs extends StatefulWidget {
  num currencyId;
  CapitalLogs({Key key, @required this.currencyId}) : super(key: key);

  @override
  _CapitalLogs createState() => _CapitalLogs();
}

class _CapitalLogs extends State<CapitalLogs> {
  final num pageSize = 10;
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
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200.0,
              child: graphic.Chart(
                data: adjustData,
                scales: {
                  'index': graphic.CatScale(
                    accessor: (map) => map['index'].toString(),
                    range: [0, 1],
                  ),
                  'type': graphic.CatScale(
                    accessor: (map) => map['type'] as String,
                  ),
                  'value': graphic.LinearScale(
                    accessor: (map) => map['value'] as num,
                    nice: true,
                  ),
                },
                geoms: [
                  graphic.LineGeom(
                    position: graphic.PositionAttr(field: 'index*value'),
                    color: graphic.ColorAttr(field: 'type'),
                    shape: graphic.ShapeAttr(
                        values: [graphic.BasicLineShape(smooth: true)]),
                  )
                ],
                axes: {
                  'index': graphic.Defaults.horizontalAxis,
                  'value': graphic.Defaults.verticalAxis,
                },
              ),
            ),
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
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          log.createTime,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
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
    setState(() {
      logs = more.toList();
      isCompleted = isLastPage;
    });
  }
}
