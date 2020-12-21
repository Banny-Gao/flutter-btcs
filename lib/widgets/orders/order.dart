import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphic/graphic.dart' as graphic;

import '../data.dart';

import '../../models/index.dart' as Models;
import '../../util/index.dart' as Utils;
import '../../common/index.dart' as Common;

class Order extends StatefulWidget {
  final String orderNumber;

  Order({Key key, @required this.orderNumber}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  Models.Pagination earningsPagination = Common.getBasicPagination();
  Models.Orders orderInfo = Models.Orders();
  List<Models.OrderEarnings> earnings = [];

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero).then((value) {
      _getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        buildCoinPirceCharts(),
      ],
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

  @override
  void dispose() {
    EasyLoading.dismiss();
    super.dispose();
  }

  _getData() async {
    EasyLoading.show();
    try {
      getOrder();
      getOrderEarnings();
    } finally {
      EasyLoading.dismiss();
    }
  }

  getOrder() async {
    final response = await Utils.API.getOrder(orderNumber: widget.orderNumber);
    final resp = Models.OrderResponse.fromJson(response);

    if (resp.code != 200) return;

    setState(() {
      orderInfo = resp.data;
    });
  }

  getOrderEarnings() async {
    final response = await Utils.API.getOrderEarnings(
      orderNumber: widget.orderNumber,
      pageSize: earningsPagination.pageSize,
      pageNum: earningsPagination.pageNum,
    );
    final resp = Models.OrderEarningsResponse.fromJson(response);

    if (resp.code != 200) return;

    bool isLastPage = resp.data.isLastPage;

    List<Models.OrderEarnings> list = resp.data.list;
    Iterable<Models.OrderEarnings> more = earnings.followedBy(list);
    setState(() {
      earnings = more.toList();
      earningsPagination.isCompleted = isLastPage;
    });
  }
}
