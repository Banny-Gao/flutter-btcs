import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:clipboard/clipboard.dart';

import '../../models/index.dart' as Models;
import '../../util/index.dart' as Utils;

// ignore: must_be_immutable
class ElectricOrder extends StatefulWidget {
  String orderNumber;
  String electricOrderNumber;

  ElectricOrder({
    Key key,
    this.orderNumber,
    this.electricOrderNumber,
  }) : super(key: key);

  @override
  _ElectricOrder createState() => _ElectricOrder();
}

class _ElectricOrder extends State<ElectricOrder> {
  Models.ElectricOrder paymentInfo = Models.ElectricOrder();

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      _getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('订单缴费'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: handleCancleOrder,
                child: Text('取消缴费订单', style: TextStyle()),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: paymentInfo.currencyIconPath != null
                          ? Image.asset(
                              'assets/img/usdt.png',
                              width: 20.0,
                              height: 20.0,
                              fit: BoxFit.fill,
                            )
                          : Container(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: paymentInfo.currencyName != null
                          ? Text(
                              'USDT支付',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          : Container(),
                    ),
                    Expanded(
                      child: paymentInfo.money != null
                          ? Text(
                              '${paymentInfo.money} USDT',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.red[400],
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          : Container(),
                    ),
                  ],
                ),
              ),
              Divider(height: 0),
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: paymentInfo.createTime != null
                    ? Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: Icon(
                              FontAwesomeIcons.clock,
                              color:
                                  Colors.primaries[3 % Colors.primaries.length],
                              size: 20.0,
                            ),
                          ),
                          Text(
                            '创建时间',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${paymentInfo.createTime}',
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      )
                    : Container(),
              ),
              Divider(height: 0),
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: paymentInfo.electricOrderNumber != null
                    ? Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: Icon(
                              FontAwesomeIcons.receipt,
                              color:
                                  Colors.primaries[1 % Colors.primaries.length],
                              size: 20.0,
                            ),
                          ),
                          Text(
                            '缴费订单编号',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Expanded(
                            child: paymentInfo.electricOrderNumber != null
                                ? Text(
                                    '${paymentInfo.electricOrderNumber}',
                                    textAlign: TextAlign.right,
                                  )
                                : Container(),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: GestureDetector(
                              onTap: () async {
                                FlutterClipboard.copy(
                                    '${paymentInfo.electricOrderNumber}');
                                EasyLoading.showInfo('已复制缴费订单编号');
                              },
                              child: Icon(
                                FontAwesomeIcons.copy,
                                size: 16.0,
                                color: Colors.black45,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(),
              ),
              Divider(height: 0),
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: paymentInfo.payAddress != null
                    ? Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: Icon(
                              FontAwesomeIcons.mapMarkerAlt,
                              color:
                                  Colors.primaries[4 % Colors.primaries.length],
                              size: 20.0,
                            ),
                          ),
                          Text(
                            '收款地址',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Expanded(
                            child: paymentInfo.payAddress != null
                                ? Padding(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      '${paymentInfo.payAddress}',
                                      textAlign: TextAlign.right,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                : Container(),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: GestureDetector(
                              onTap: () async {
                                FlutterClipboard.copy(
                                    '${paymentInfo.payAddress}');
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
                      )
                    : Container(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: paymentInfo.payQr != null
                    ? Image.network(
                        paymentInfo.payQr,
                        width: 200.0,
                        height: 200.0,
                      )
                    : paymentInfo.payQr != null
                        ? QrImage(
                            data: paymentInfo.payQr,
                            version: QrVersions.auto,
                            size: 200.0,
                          )
                        : Container(),
              ),
              Divider(height: 0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('客服微信: ${paymentInfo.wxAccount}'),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: GestureDetector(
                      onTap: () async {
                        FlutterClipboard.copy('${paymentInfo.wxAccount}');
                        EasyLoading.showInfo('已复制客服微信');
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
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
                child: paymentInfo.wxQr != null
                    ? Image.network(
                        paymentInfo.wxQr,
                        width: 200.0,
                        height: 200.0,
                      )
                    : paymentInfo.wxAccount != null
                        ? QrImage(
                            data: paymentInfo.wxAccount,
                            version: QrVersions.auto,
                            size: 200.0,
                          )
                        : Container(),
              ),
              Container(
                margin: EdgeInsets.only(top: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RaisedButton(
                      color: Theme.of(context).primaryColor,
                      highlightColor: Theme.of(context).primaryColorDark,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 20.0,
                        ),
                        child: Text(
                          "已支付",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      onPressed: handlePayed,
                    ),
                    OutlineButton(
                      highlightedBorderColor: Colors.black54,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 20.0,
                        ),
                        child: Text(
                          "稍后支付",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  _getData() async {
    EasyLoading.show();
    await getOrderPaymentInfo();

    EasyLoading.dismiss();
  }

  getOrderPaymentInfo() async {
    final response = widget.electricOrderNumber != null
        ? await Utils.API
            .getElectricOrder(electricOrderNumber: widget.electricOrderNumber)
        : await Utils.API.addElectricOrder(orderNumber: widget.orderNumber);
    final resp = Models.ElectricOrderResponse.fromJson(response);

    if (resp.code != 200) {
      EasyLoading.showInfo(resp.message, duration: Duration(seconds: 3));
      await Future.delayed(Duration(seconds: 3));
      EasyLoading.dismiss();
      Navigator.of(context).pop();
      return;
    }

    if (mounted)
      setState(() {
        paymentInfo = resp.data;
      });
  }

  handlePayed() async {
    final response = await Utils.API.confirmElectricOrderPayed(
        electricOrderNumber: paymentInfo.electricOrderNumber);
    final resp = Models.NonstandardResponse.fromJson(response);
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

    await EasyLoading.showInfo('请等待工作人员审核');
    Navigator.of(context).pop();
  }

  handleCancleOrder() async {
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
        electricOrderNumber: paymentInfo.electricOrderNumber);
    final resp = Models.NonstandardResponse.fromJson(response);

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

    await EasyLoading.showInfo(
      '缴费订单已取消',
      duration: Duration(seconds: 2),
    );

    Navigator.of(context).pop();
  }
}
