import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../routes.dart';
import '../../models/index.dart' as Models;
import '../../util/index.dart' as Utils;

import 'electricOrder.dart';
import 'electrics.dart';

class Orders extends StatefulWidget {
  Orders({Key key}) : super(key: key);

  @override
  _Orders createState() => _Orders();
}

class _Orders extends State<Orders> with RouteAware {
  final num pageSize = 10;
  num pageNum = 1;
  bool isCompleted = false;
  bool isLoading = false;

  List<Models.Orders> orders = [];

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
  void dispose() {
    EasyLoading.dismiss();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void didPopNext() {
    _refreshOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的订单'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: showElectrics,
                child: Text('缴费记录', style: TextStyle()),
              ),
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _refreshOrders();
        },
        child: ListView.custom(
          controller: _scrollController,
          itemExtent: 230.0,
          childrenDelegate: SliverChildBuilderDelegate(
            (BuildContext context, index) => buildListItem(index),
            childCount: orders.length + 1,
          ),
        ),
      ),
    );
  }

  Widget buildListItem(index) {
    if (index == orders.length) {
      return isCompleted
          ? Container(
              height: 50.0,
              alignment: Alignment.center,
              padding: EdgeInsets.all(16.0),
              child: Text(
                orders.length == 0
                    ? "暂无数据"
                    : orders.length * 220 > MediaQuery.of(context).size.height
                        ? "没有更多了"
                        : '',
                style: TextStyle(color: Colors.grey),
              ),
            )
          : Container();
    }

    final order = orders[index];
    final List<Widget> children = [];

    children.add(buildTitle(order));
    children.addAll(buildBasicInfos(order));

    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 6.0, 10.0, 6.0),
      child: Card(
        shadowColor: Theme.of(context).primaryColor,
        child: OverflowBox(
          child: InkWell(
            onTap: () {
              navigateToOrder(order);
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: children,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTitle(order) {
    return Row(
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
                color: Colors
                    .primaries[Random().nextInt(17) % Colors.primaries.length],
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
          ),
        ),
      ],
    );
  }

  List<Widget> buildBasicInfos(Models.Orders order) {
    return <Widget>[
      Padding(
        padding: EdgeInsets.only(top: 4.0),
        child: Text(
          order.groupName,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 4.0),
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
        padding: EdgeInsets.only(top: 4.0),
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
      // Padding(
      //   padding: EdgeInsets.only(top: 4.0),
      //   child: Row(
      //     children: [
      //       Expanded(
      //         child: Text(
      //           '收益截止日期',
      //           style: TextStyle(
      //             fontSize: 12.0,
      //           ),
      //         ),
      //       ),
      //       Text(
      //         '${order.miningEndTime}',
      //         style: TextStyle(
      //           color: Colors.black87,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      Padding(
        padding: EdgeInsets.only(top: 4.0),
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
      // Padding(
      //   padding: EdgeInsets.only(top: 4.0),
      //   child: Row(
      //     children: [
      //       Expanded(
      //         child: Text(
      //           '剩余分期天数',
      //           style: TextStyle(
      //             fontSize: 12.0,
      //           ),
      //         ),
      //       ),
      //       Text(
      //         '${order.paymentNumber} 天',
      //         style: TextStyle(
      //           color: Colors.black87,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      // Padding(
      //   padding: EdgeInsets.only(top: 4.0),
      //   child: Row(
      //     children: [
      //       Expanded(
      //         child: Text(
      //           '未付款分期',
      //           style: TextStyle(
      //             fontSize: 12.0,
      //           ),
      //         ),
      //       ),
      //       Text(
      //         '${order.surplusMoney} ${order.currencyName}',
      //         style: TextStyle(
      //           color: Colors.red[400],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      Padding(
        padding: EdgeInsets.only(top: 4.0),
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
      Padding(
        padding: EdgeInsets.only(top: 10.0),
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
                        showPopUpEectricOrder(order);
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
                      : OutlineButton(
                          borderSide: BorderSide(
                            color: Colors.black54,
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 4.0,
                            horizontal: 6.0,
                          ),
                          child: Text(
                            "查看订单",
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                          onPressed: () {
                            navigateToOrder(order);
                          },
                        ),
            ),
          ],
        ),
      )
    ];
  }

  _refreshOrders() {
    setState(() {
      pageNum = 1;
      orders = [];
    });
    _getData();
  }

  _getData() async {
    EasyLoading.show();
    try {
      await _getOrders();
    } finally {
      EasyLoading.dismiss();
    }
  }

  _getOrders() async {
    final response = await Utils.API.getOrders(
      pageNum: pageNum,
      pageSize: pageSize,
    );
    final resp = Models.OrdersResponse.fromJson(response);

    if (resp.code != 200) return;
    bool isLastPage = resp.data.isLastPage;

    List<Models.Orders> list = resp.data.list;
    Iterable<Models.Orders> more = orders.followedBy(list);
    setState(() {
      orders = more.toList();
      isCompleted = isLastPage;
    });
  }

  showPopUpEectricOrder(Models.Orders order) {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => ElectricOrder(orderNumber: order.orderNumber),
      ),
    );
  }

  navigateToOrder(Models.Orders order) {
    Navigator.of(context).pushNamed(
      '/order',
      arguments: {'orderNumber': order.orderNumber},
    );
  }

  showElectrics() {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => Electrics(),
      ),
    );
  }
}
