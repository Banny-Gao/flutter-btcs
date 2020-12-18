import 'package:flutter/material.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';

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
        title: Text('订单支付'),
      ),
      body: Column(
        children: [
          Row(),
        ],
      ),
    );
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
  }
}
