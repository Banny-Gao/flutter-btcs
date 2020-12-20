import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../models/index.dart' as Models;
import '../../util/index.dart' as Utils;

// ignore: must_be_immutable
class OrderPayment extends StatefulWidget {
  String orderNumber;

  OrderPayment({Key key, @required this.orderNumber}) : super(key: key);

  @override
  _OrderPayment createState() => _OrderPayment();
}

class _OrderPayment extends State<OrderPayment> {
  Models.PaymentInfo paymentInfo = Models.PaymentInfo();

  Timer _timer;
  bool waitToPayClick = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      _getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (waitToPayClick) return true;
        return await handleWaitToPay();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('订单支付'),
          actions: [
            paymentInfo.countDownTime != null && paymentInfo.countDownTime > 0
                ? Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: handleCancleOrder,
                        child: Text('取消订单', style: TextStyle()),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: paymentInfo.currencyIconPath != null
                    ? Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    '${paymentInfo.currencyName}支付',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          paymentInfo.countDownTime > 0
                              ? RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '请及时支付:  ',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      TextSpan(
                                        text: Utils.constructTime(
                                            paymentInfo.countDownTime ~/ 1000),
                                        style: TextStyle(
                                          color: Colors.red[400],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Text(
                                  '已过期',
                                  style: TextStyle(
                                    color: Theme.of(context).disabledColor,
                                  ),
                                ),
                        ],
                      )
                    : Container(),
              ),
              Divider(height: 0),
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: paymentInfo.currencyIconPath != null
                          ? Image.network(
                              paymentInfo.currencyIconPath,
                              width: 20.0,
                              height: 20.0,
                              fit: BoxFit.fill,
                            )
                          : Icon(
                              FontAwesomeIcons.btc,
                              color: Colors
                                  .primaries[14 % Colors.primaries.length],
                            ),
                    ),
                    Text(
                      '支付金额',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(
                      child: paymentInfo.money != null
                          ? Text(
                              '${paymentInfo.money} ${paymentInfo.currencyName}',
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
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: Icon(
                        FontAwesomeIcons.clock,
                        color: Colors.primaries[3 % Colors.primaries.length],
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
                      child: paymentInfo.createTime != null
                          ? Text(
                              '${paymentInfo.createTime}',
                              textAlign: TextAlign.right,
                            )
                          : Container(),
                    ),
                  ],
                ),
              ),
              Divider(height: 0),
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: Icon(
                        FontAwesomeIcons.asterisk,
                        color: Colors.primaries[5 % Colors.primaries.length],
                        size: 20.0,
                      ),
                    ),
                    Text(
                      '机型/数量',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(
                      child: paymentInfo.lcd != null
                          ? Text(
                              '${paymentInfo.lcd} / ${paymentInfo.buyNumber}',
                              textAlign: TextAlign.right,
                            )
                          : Container(),
                    ),
                  ],
                ),
              ),
              Divider(height: 0),
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: Icon(
                        FontAwesomeIcons.receipt,
                        color: Colors.primaries[1 % Colors.primaries.length],
                        size: 20.0,
                      ),
                    ),
                    Text(
                      '订单编号',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(
                      child: paymentInfo.orderNumber != null
                          ? Text(
                              '${paymentInfo.orderNumber}',
                              textAlign: TextAlign.right,
                            )
                          : Container(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Icon(
                        FontAwesomeIcons.copy,
                        size: 16.0,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 0),
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: Icon(
                        FontAwesomeIcons.mapMarkerAlt,
                        color: Colors.primaries[4 % Colors.primaries.length],
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
                      child: paymentInfo.topAddress != null
                          ? Text(
                              '${paymentInfo.topAddress}',
                              textAlign: TextAlign.right,
                            )
                          : Container(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Icon(
                        FontAwesomeIcons.copy,
                        size: 16.0,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: paymentInfo.payQr != null
                    ? Image.network(
                        paymentInfo.payQr,
                        width: 200.0,
                        height: 200.0,
                      )
                    : paymentInfo.topAddress != null
                        ? QrImage(
                            data: paymentInfo.topAddress,
                            version: QrVersions.auto,
                            size: 200.0,
                          )
                        : Container(),
              ),
              Divider(height: 0),
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
                      onPressed: handleWaitToPay,
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

    if (_timer != null) {
      _timer.cancel();
    }
  }

  _getData() async {
    EasyLoading.show();
    try {
      await getOrderPaymentInfo();
    } finally {
      EasyLoading.dismiss();
    }
  }

  getOrderPaymentInfo() async {
    final response =
        await Utils.API.getOrderPaymentInfo(orderNumber: widget.orderNumber);
    final resp = Models.PaymentInfoResponse.fromJson(response);

    if (resp.code != 200) {
      await EasyLoading.showError(resp.message);
      Navigator.of(context).pop();
      return;
    }

    paymentInfo = resp.data;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (paymentInfo.countDownTime > 0) {
        setState(() {
          paymentInfo.countDownTime -= 1000;
        });
      }
    });
  }

  handlePayed() async {
    final response =
        await Utils.API.confirmOrderPayed(orderNumber: paymentInfo.orderNumber);
    final resp = Models.NonstandardResponse.fromJson(response);

    if (resp.code != 200) {
      EasyLoading.showError(resp.message);
      return;
    }

    await EasyLoading.showInfo('请等待工作人员审核');
    Navigator.of(context).pop();
  }

  Future<bool> willPopAssert() async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('提示'),
          content: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '订单将在 ',
                  style: TextStyle(color: Colors.black54),
                ),
                TextSpan(
                  text:
                      '${Utils.constructTime(paymentInfo.countDownTime ~/ 1000)}',
                  style: TextStyle(
                    color: Colors.red[400],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: ' 后关闭',
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('取消'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            FlatButton(
              child: Text('稍后支付'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> handleWaitToPay() async {
    final bool isWait = await willPopAssert();

    if (isWait) {
      setState(() {
        waitToPayClick = true;
        Navigator.of(context).pop();
      });
      return true;
    }

    return false;
  }

  handleCancleOrder() async {
    final bool isCancel = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('提示'),
          content: Text('确认取消当前订单吗？'),
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

    final response =
        await Utils.API.cancelOrder(orderNumber: paymentInfo.orderNumber);
    final resp = Models.NonstandardResponse.fromJson(response);

    if (resp.code != 200) {
      EasyLoading.showError(resp.message);
      return;
    }

    await EasyLoading.showInfo(
      '订单已取消',
      duration: Duration(seconds: 2),
    );

    Navigator.of(context).pop();
  }
}
