import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../scopedModels/index.dart';
import '../../models/index.dart' as Models;
import '../../util/index.dart' as Utils;

import 'capitalLogs.dart';
import 'withdraw.dart';

class Assets extends StatefulWidget {
  Assets({Key key}) : super(key: key);

  @override
  _Assets createState() => _Assets();
}

class _Assets extends State<Assets> {
  List<Models.Asset> assets = [];
  num currencyId;

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    if (AppModel.coinList.length != 0) {
      setState(() {
        currencyId = AppModel.coinList[0].currencyId;
      });
    }
    Future.delayed(Duration.zero).then((value) {
      _getData();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (context, child, model) => Scaffold(
        appBar: AppBar(
          title: Text('我的资产'),
          actions: [
            DropdownButton(
              hint: Text('选择币种'),
              underline: Container(),
              value: currencyId,
              items: model.coins
                  .map<DropdownMenuItem>(
                    (coin) => DropdownMenuItem(
                      child: Row(
                        children: [
                          Image.network(
                            coin.iconPath,
                            width: 18.0,
                            height: 18.0,
                            fit: BoxFit.fill,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 6.0),
                            child: Text(
                              coin.currencyName,
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                      value: coin.currencyId,
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                currencyId = value;
                _getData();
              },
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            _getData();
          },
          child: ListView.custom(
            controller: _scrollController,
            itemExtent: 130.0,
            childrenDelegate: SliverChildBuilderDelegate(
              (BuildContext context, index) => buildListItem(model, index),
              childCount: assets.length,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildListItem(model, index) {
    final Models.Asset asset = assets[index];

    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 6.0, 10.0, 6.0),
      child: Card(
        color: Colors.primaries[Random().nextInt(10) + 1],
        child: OverflowBox(
          child: InkWell(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          asset.currencyName,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      asset.isShiftTo == 1
                          ? Padding(
                              padding: EdgeInsets.only(right: 10.0),
                              child: InkWell(
                                onTap: () {
                                  _showPopUpWithdraw(asset);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white38,
                                    borderRadius: BorderRadius.circular(14.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 3.0,
                                      horizontal: 10.0,
                                    ),
                                    child: Text(
                                      '提币',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white38,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: InkWell(
                          onTap: () {
                            _showPopUpLogs(asset);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 3.0,
                              horizontal: 10.0,
                            ),
                            child: Text(
                              '明细',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              '可用资产(${asset.currencyName})',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 10.0,
                              ),
                              child: Text(
                                '${asset.currencyNumber}',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              '冻结资产(${asset.currencyName})',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 10.0,
                              ),
                              child: Text(
                                '${asset.freezeNumber}',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _getData() async {
    EasyLoading.show();
    try {
      await _getAssets();
    } finally {
      EasyLoading.dismiss();
    }
  }

  _getAssets() async {
    if (currencyId == null) return;

    final response = await Utils.API.getAssets(currencyId: currencyId);
    final resp = Models.AssetsResponse.fromJson(response);

    if (resp.code != 200) return;

    setState(() {
      assets = resp.data;
    });
  }

  _showPopUpLogs(Models.Asset asset) {
    Navigator.of(context).push(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => CapitalLogs(
        currencyId: asset.currencyId,
      ),
    ));
  }

  _showPopUpWithdraw(Models.Asset asset) {
    Navigator.of(context).push(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => Withdraw(
        asset: asset,
      ),
    ));
  }
}
