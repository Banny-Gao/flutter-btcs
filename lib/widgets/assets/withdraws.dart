import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../models/index.dart' as Models;
import '../../util/index.dart' as Utils;
import '../../scopedModels/index.dart';

class Withdraws extends StatefulWidget {
  Withdraws({Key key}) : super(key: key);

  @override
  _Withdraws createState() => _Withdraws();
}

class _Withdraws extends State<Withdraws> {
  final num pageSize = 10;
  num pageNum = 1;
  bool isCompleted = false;
  bool isLoading = false;

  List<Models.Withdraw> withdraws = [];

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('提现明细'),
      ),
      body: ScopedModelDescendant<AppModel>(
        builder: (context, child, model) => RefreshIndicator(
          onRefresh: () async {
            _refreshOrders();
          },
          child: ListView.custom(
            controller: _scrollController,
            itemExtent: 130.0,
            childrenDelegate: SliverChildBuilderDelegate(
              (BuildContext context, index) => buildListItem(index, model),
              childCount: withdraws.length + 1,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildListItem(index, model) {
    if (index == withdraws.length) {
      return isCompleted
          ? Container(
              height: 50.0,
              alignment: Alignment.center,
              padding: EdgeInsets.all(16.0),
              child: Text(
                withdraws.length == 0
                    ? "暂无数据"
                    : withdraws.length * 130 >
                            MediaQuery.of(context).size.height
                        ? "没有更多了"
                        : '',
                style: TextStyle(color: Colors.grey),
              ),
            )
          : Container();
    }

    final withdraw = withdraws[index];
    final List<Widget> children = [];

    children.add(buildTitle(withdraw, model));
    children.addAll(buildBasicInfos(withdraw));

    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 6.0, 10.0, 6.0),
      child: Card(
        shadowColor: Theme.of(context).primaryColor,
        child: OverflowBox(
          child: InkWell(
            onTap: () {},
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

  Widget buildTitle(Models.Withdraw withdraw, model) {
    final Models.Coin coin = _getCoinById(model.coins, withdraw.currencyId);

    return Row(
      children: [
        coin.iconPath != null
            ? Image.network(
                coin.iconPath,
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
            withdraw.currencyName,
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
          withdraw.status == 2
              ? withdraw.refReason
              : Utils.WithdrawStatus[withdraw.status],
          style: TextStyle(
            color: withdraw.status == 2 ? Colors.black54 : Colors.red[400],
          ),
        ),
      ],
    );
  }

  List<Widget> buildBasicInfos(Models.Withdraw withdraw) {
    return <Widget>[
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
              '${withdraw.createTime}',
              style: TextStyle(
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
      withdraw.opTime != null
          ? Padding(
              padding: EdgeInsets.only(top: 4.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '审核时间',
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                  Text(
                    '${withdraw.opTime}',
                    style: TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            )
          : Container(),
      Padding(
        padding: EdgeInsets.only(top: 4.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                '提现金额',
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ),
            Text(
              '${withdraw.money} ${withdraw.currencyName} ',
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
                '手续费',
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ),
            Text(
              '${withdraw.serviceCharge} ${withdraw.currencyName} ',
              style: TextStyle(
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    ];
  }

  _getCoinById(coins, id) {
    final coin = coins.length != 0
        ? coins.singleWhere((coin) => coin.currencyId == id)
        : null;
    return coin;
  }

  _refreshOrders() {
    if (mounted)
      setState(() {
        pageNum = 1;
        withdraws = [];
      });
    _getData();
  }

  _getData() async {
    EasyLoading.show();
    try {
      await _getWithdraws();
    } finally {
      EasyLoading.dismiss();
    }
  }

  _getWithdraws() async {
    final response = await Utils.API.getWithdrawAudits(
      pageNum: pageNum,
      pageSize: pageSize,
    );
    final resp = Models.WithdrawsResponse.fromJson(response);

    if (resp.code != 200) return;
    bool isLastPage = resp.data.isLastPage;

    List<Models.Withdraw> list = resp.data.list;
    Iterable<Models.Withdraw> more = withdraws.followedBy(list);
    if (mounted)
      setState(() {
        withdraws = more.toList();
        isCompleted = isLastPage;
      });
  }
}
