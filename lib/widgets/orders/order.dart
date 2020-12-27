import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphic/graphic.dart' as graphic;

import '../../routes.dart';
import '../../models/index.dart' as Models;
import '../../util/index.dart' as Utils;
import '../../common/index.dart' as Common;

import 'electricOrder.dart';

class Order extends StatefulWidget {
  final String orderNumber;

  Order({Key key, @required this.orderNumber}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OrderState();
}

class _OrderState extends State<Order> with RouteAware {
  Models.Pagination earningsPagination =
      Common.getBasicPagination(pageSize: 100);
  Models.Orders order = Models.Orders();
  List<Models.OrderEarnings> earnings = [];

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero).then((value) {
      _getData();
    });
  }

  @override
  void dispose() {
    EasyLoading.dismiss();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void didPopNext() {
    _getData();
  }

  get computedEarnings {
    List list = [];
    earnings.forEach((earning) {
      list.add({
        'type': 'earnings',
        'value': earning.earnings,
        'createTime': earning.createTime,
        'longTime': earning.longTime,
      });
      list.add({
        'type': 'platformMoney',
        'value': earning.platformMoney,
        'longTime': earning.longTime,
        'createTime': earning.createTime,
      });
      list.add({
        'type': 'totalEarnings',
        'value': earning.totalEarnings,
        'longTime': earning.longTime,
        'createTime': earning.createTime,
      });
    });
    list.sort(
        (left, right) => left['createTime'].compareTo(right['createTime']));
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('订单详情'),
      ),
      body: ListView(
        children: <Widget>[
          computedEarnings.length != 0 ? buildOrderEarnings() : Container(),
          order.orderNumber != null ? buildOrderInfo() : Container(),
        ],
      ),
    );
  }

  Widget buildOrderEarnings() {
    return Container(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200.0,
            child: graphic.Chart(
              data: computedEarnings,
              scales: {
                'createTime': graphic.CatScale(
                  accessor: (map) => map['createTime'].toString(),
                  tickCount:
                      computedEarnings.length > 4 ? 4 : computedEarnings.length,
                ),
                'type': graphic.CatScale(
                  accessor: (map) => map['type'],
                ),
                'value': graphic.LinearScale(
                  accessor: (map) => map['value'] as num,
                  nice: true,
                ),
              },
              geoms: [
                graphic.LineGeom(
                  position: graphic.PositionAttr(field: 'createTime*value'),
                  color: graphic.ColorAttr(field: 'type'),
                  shape: graphic.ShapeAttr(
                      values: [graphic.BasicLineShape(smooth: true)]),
                )
              ],
              axes: {
                'createTime': graphic.Defaults.horizontalAxis,
                'value': graphic.Defaults.verticalAxis,
              },
              interactions: [
                graphic.Defaults.xPaning,
                graphic.Defaults.xScaling,
              ],
            ),
          ),
        ],
      ),
    );
  }

  _getData() async {
    EasyLoading.show();
    try {
      await getOrder();
      await getOrderEarnings();
    } finally {
      EasyLoading.dismiss();
    }
  }

  getOrder() async {
    final response = await Utils.API.getOrder(orderNumber: widget.orderNumber);
    final resp = Models.OrderResponse.fromJson(response);

    if (resp.code != 200) return;

    if (mounted)
      setState(() {
        order = resp.data;
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
    if (mounted)
      setState(() {
        earnings = more.toList();
        earningsPagination.isCompleted = isLastPage;
      });
  }

  Widget buildTitle(String title) {
    return Padding(
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

  Widget buildOrderInfo() {
    final List<Widget> children = [];

    children.add(buildTitle('订单状态'));
    children.add(buildStatus());
    children.add(buildTitle('订单信息'));
    children.addAll(buildBasicInfos());
    children.add(buildAction());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: children,
    );
  }

  Widget buildStatus() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: [
          order.currencyIconPath != null
              ? Image.network(
                  order.currencyIconPath,
                  width: 24.0,
                  height: 24.0,
                  fit: BoxFit.fill,
                )
              : Icon(
                  FontAwesomeIcons.btc,
                  color: Colors.primaries[
                      Random().nextInt(17) % Colors.primaries.length],
                ),
          Padding(
            padding: EdgeInsets.only(left: 12.0),
            child: Text(
              order.currencyName,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
          Expanded(
            child: Container(),
          ),
          Text(
            order.status == 2
                ? Utils.CauseStatus[order.causeStatus - 1]
                : order.status == 1
                    ? order.energyStatus == 0
                        ? Utils.EnergyStatus[order.energyStatus]
                        : Utils.RobotStatus[order.robotStatus]
                    : Utils.OrdersStatus[order.status],
            style: TextStyle(
              color: order.status == 2 ? Colors.black54 : Colors.red[400],
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildBasicInfos() {
    return <Widget>[
      Padding(
        padding: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 6.0),
        child: Text(
          order.groupName,
          softWrap: true,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 6.0),
        child: order.producImg != null
            ? Image.network(
                order.producImg,
                fit: BoxFit.fitWidth,
              )
            : Container(),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 6.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                '购买机型',
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ),
            Text(
              '${order.lcd}',
              style: TextStyle(
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 6.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                '订单编号',
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ),
            Text(
              '${order.orderNumber}',
              style: TextStyle(
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 6.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                '创建日期',
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ),
            Text(
              '${order.createTime}',
              style: TextStyle(
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
      order.miningEndTime != null
          ? Padding(
              padding: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 6.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '收益截止日期',
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                  Text(
                    '${order.miningEndTime}',
                    style: TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            )
          : Container(),
      Padding(
        padding: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 6.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                '剩余分期天数',
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ),
            Text(
              '${order.paymentNumber} 天',
              style: TextStyle(
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 6.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                '未付款分期',
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ),
            Text(
              '${order.surplusMoney} ${order.currencyName}',
              style: TextStyle(
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 6.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                '购买数量/总金额',
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ),
            Text(
              '${order.buyNumber} / ${order.money} ${order.currencyName}',
              style: TextStyle(
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
      order.energyStatus == 0
          ? Padding(
              padding: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 6.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '欠费金额',
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                  Text(
                    '${order.awaitElectricity} ${order.currencyName}',
                    style: TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            )
          : Container(),
      order.status == 1 || order.status == 3
          ? Padding(
              padding: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 6.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '总收益',
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                  Text(
                    '${order.totalEarnings} ${order.currencyName}',
                    style: TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            )
          : Container(),
    ];
  }

  Widget buildAction() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 20.0),
      child: Row(
        children: [
          Expanded(
              child: order.status == 1 && order.energyStatus == 0
                  ? RaisedButton(
                      color: Colors.red[400],
                      padding: EdgeInsets.symmetric(
                        vertical: 4.0,
                        horizontal: 6.0,
                      ),
                      child: Text(
                        "去缴费",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        showPopUpEectricOrder();
                      },
                    )
                  : order.status == 0
                      ? RaisedButton(
                          color: Colors.red[400],
                          padding: EdgeInsets.symmetric(
                            vertical: 4.0,
                            horizontal: 6.0,
                          ),
                          child: Text(
                            "去支付",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed('/orderPayment', arguments: {
                              'orderNumber': order.orderNumber,
                            });
                          },
                        )
                      : Container()),
        ],
      ),
    );
  }

  showPopUpEectricOrder() {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => ElectricOrder(orderNumber: order.orderNumber),
      ),
    );
  }
}
