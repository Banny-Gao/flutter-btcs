import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../scopedModels/index.dart';
import '../../models/index.dart' as Models;
import '../../util/index.dart' as Utils;

import 'newWalletAddress.dart';

class WalletAddresses extends StatefulWidget {
  WalletAddresses({Key key}) : super(key: key);

  @override
  _WalletAddresses createState() => _WalletAddresses();
}

class _WalletAddresses extends State<WalletAddresses> {
  final num pageSize = 10;
  num pageNum = 1;
  bool isCompleted = false;
  bool isLoading = false;

  List<Models.WalletAddress> walletAddresses = [];
  List<Models.Coin> coins = [];

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
          title: Text('我的钱包'),
          actions: [
            FlatButton(
              onPressed: _showPopUpNewAddress,
              child: Text(
                '新建地址',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Theme.of(context).bottomAppBarColor,
                ),
              ),
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            _refreshAddresses();
          },
          child: ListView.custom(
            controller: _scrollController,
            itemExtent: 80.0,
            childrenDelegate: SliverChildBuilderDelegate(
              (BuildContext context, index) => buildListItem(index),
              childCount: walletAddresses.length + 1,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildListItem(index) {
    if (index == walletAddresses.length) {
      return isCompleted
          ? Container(
              height: 50.0,
              alignment: Alignment.center,
              padding: EdgeInsets.all(16.0),
              child: Text(
                walletAddresses.length == 0
                    ? "暂无数据"
                    : walletAddresses.length * 80 >
                            MediaQuery.of(context).size.height
                        ? "没有更多了"
                        : '',
                style: TextStyle(color: Colors.grey),
              ),
            )
          : Container();
    }

    final iconPath = _getIconPathById(walletAddresses[index].currencyId);

    return Container(
      height: 80.0,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          shadowColor: Theme.of(context).primaryColor,
          child: InkWell(
            onTap: () {},
            child: Column(
              children: [
                Row(
                  children: [
                    iconPath != null
                        ? Image.network(
                            iconPath,
                            width: 24.0,
                            height: 24.0,
                            fit: BoxFit.fill,
                          )
                        : Icon(
                            FontAwesomeIcons.btc,
                            color: Colors.primaries[
                                Random().nextInt(17) % Colors.primaries.length],
                          ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _refreshAddresses() {
    pageNum = 1;
    walletAddresses = [];
    _getData();
  }

  _getData() async {
    EasyLoading.show();
    try {
      await _getIcons();
      await _getWalletAddresses();
    } finally {
      EasyLoading.dismiss();
    }
  }

  _getIcons() async {
    final response = await Utils.API.getCoinTypes();
    final resp = Models.CoinsResponse.fromJson(response);

    if (resp.code != 200) {
      EasyLoading.showError(resp.message);
      return;
    }

    coins = resp.data;
  }

  _getWalletAddresses() async {
    final response = await Utils.API.getWalletAddresses(
      pageNum: pageNum,
      pageSize: pageSize,
    );
    final resp = Models.WalletAddressesResponse.fromJson(response);

    if (resp.code != 200) return;
    bool isLastPage = resp.data.isLastPage;

    List<Models.WalletAddress> list = resp.data.list;
    Iterable<Models.WalletAddress> more = walletAddresses.followedBy(list);
    setState(() {
      walletAddresses = more.toList();
      isCompleted = isLastPage;
    });
  }

  _showPopUpNewAddress() {
    Navigator.of(context).push(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) =>
          NewWalletAddress(refreshWalletAddresses: _refreshAddresses),
    ));
  }

  _getIconPathById(id) {
    final coin = coins.length != 0
        ? coins.singleWhere((coin) => coin.currencyId == id)
        : null;
    return coin != null ? coin.iconPath : null;
  }
}