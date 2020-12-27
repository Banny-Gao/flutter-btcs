import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:clipboard/clipboard.dart';

import '../../scopedModels/index.dart';
import '../../models/index.dart' as Models;
import '../../util/index.dart' as Utils;

import 'electricOrder.dart';

class Electrics extends StatefulWidget {
  Electrics({Key key}) : super(key: key);

  @override
  _Electrics createState() => _Electrics();
}

class _Electrics extends State<Electrics> {
  final num pageSize = 10;
  num pageNum = 1;
  bool isCompleted = false;
  bool isLoading = false;

  List<Models.ElectricOrder> electrics = [];

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
          title: Text('缴费记录'),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            _refreshElectrics();
          },
          child: ListView.custom(
            controller: _scrollController,
            itemExtent: 185.0,
            childrenDelegate: SliverChildBuilderDelegate(
              (BuildContext context, index) => buildListItem(model, index),
              childCount: electrics.length + 1,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildListItem(model, index) {
    if (index == electrics.length) {
      return isCompleted
          ? Container(
              height: 50.0,
              alignment: Alignment.center,
              padding: EdgeInsets.all(16.0),
              child: Text(
                electrics.length == 0
                    ? "暂无数据"
                    : electrics.length * 120 >
                            MediaQuery.of(context).size.height
                        ? "没有更多了"
                        : '',
                style: TextStyle(color: Colors.grey),
              ),
            )
          : Container();
    }

    final coin = _getCoinById(model.coins, electrics[index].currencyId);
    final electric = electrics[index];

    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 6.0, 10.0, 6.0),
      child: Slidable(
        actionPane: SlidableStrechActionPane(),
        actionExtentRatio: 0.20,
        child: Card(
          shadowColor: Theme.of(context).primaryColor,
          child: OverflowBox(
            child: InkWell(
              onTap: electric == 0
                  ? () {
                      showPopUpEectricOrder(electric);
                    }
                  : () {},
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        coin != null
                            ? Image.network(
                                coin.iconPath,
                                width: 24.0,
                                height: 24.0,
                                fit: BoxFit.fill,
                              )
                            : Icon(
                                FontAwesomeIcons.btc,
                                color: Colors.primaries[Random().nextInt(17) %
                                    Colors.primaries.length],
                              ),
                        coin != null
                            ? Padding(
                                padding: EdgeInsets.only(left: 12.0),
                                child: Text(
                                  coin.currencyName,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              )
                            : Container(),
                        Expanded(
                          child: Text(
                            electric.orderStatus != null
                                ? Utils
                                    .ElectricOrderStatus[electric.orderStatus]
                                : '',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.red[400],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 6.0),
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
                            '${electric.orderNumber}',
                            style: TextStyle(
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 6.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '缴费订单编号',
                              style: TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                          Text(
                            '${electric.electricOrderNumber}',
                            style: TextStyle(
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 6.0),
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
                            '${electric.createTime}',
                            style: TextStyle(
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 6.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '支付金额',
                              style: TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                          Text(
                            '${electric.money} ${coin.currencyName}',
                            style: TextStyle(
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 6.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '支付地址',
                              style: TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                          Text(
                            '${electric.payAddress}',
                            style: TextStyle(
                              color: Colors.black87,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: GestureDetector(
                              onTap: () async {
                                FlutterClipboard.copy('${electric.payAddress}');
                                EasyLoading.showInfo('已复制支付地址');
                              },
                              child: Icon(
                                FontAwesomeIcons.copy,
                                size: 16.0,
                                color: Colors.black45,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        secondaryActions: electric.orderStatus == 0
            ? [
                IconSlideAction(
                  caption: '取消订单',
                  color: Colors.red,
                  icon: FontAwesomeIcons.trashAlt,
                  onTap: () {
                    handleCancleOrder(electric);
                  },
                ),
              ]
            : [],
      ),
    );
  }

  _refreshElectrics() {
    pageNum = 1;
    electrics = [];
    _getData();
  }

  _getData() async {
    EasyLoading.show();
    try {
      await _getElectrics();
    } finally {
      EasyLoading.dismiss();
    }
  }

  _getElectrics() async {
    final response = await Utils.API.getElectrics(
      pageNum: pageNum,
      pageSize: pageSize,
    );
    final resp = Models.ElectricsResponse.fromJson(response);

    if (resp.code != 200) return;
    bool isLastPage = resp.data.isLastPage;

    List<Models.ElectricOrder> list = resp.data.list;
    Iterable<Models.ElectricOrder> more = electrics.followedBy(list);
    if (mounted)
      setState(() {
        electrics = more.toList();
        isCompleted = isLastPage;
      });
  }

  _getCoinById(coins, id) {
    final coin = coins.length != 0
        ? coins.singleWhere((coin) => coin.currencyId == id)
        : null;
    return coin;
  }

  showPopUpEectricOrder(Models.ElectricOrder electricOrder) {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => ElectricOrder(
            electricOrderNumber: electricOrder.electricOrderNumber),
      ),
    );
  }

  handleCancleOrder(electricOrder) async {
    final bool isCancel = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('提示'),
          content: Text('确认取消当前缴费订单吗？'),
          actions: <Widget>[
            FlatButton(
              child: Text('取消'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            FlatButton(
              child: Text('确认'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    if (!isCancel) return;

    final response = await Utils.API.cancelElectricOrderPayed(
        electricOrderNumber: electricOrder.electricOrderNumber);
    final resp = Models.NonstandardResponse.fromJson(response);

    if (resp.code != 200) {
      EasyLoading.showError(resp.message);
      return;
    }

    await EasyLoading.showInfo(
      '缴费订单已取消',
      duration: Duration(seconds: 2),
    );

    _refreshElectrics();
  }
}
