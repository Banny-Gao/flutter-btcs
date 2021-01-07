import 'package:flutter/material.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../models/index.dart' as Models;
import '../../util/index.dart' as Utils;
import '../contentPreview/contentPreview.dart';

// ignore: must_be_immutable
class OrderSubmit extends StatefulWidget {
  Models.SubmitGroupResponseData orderSubmitInfo;

  OrderSubmit({Key key, @required this.orderSubmitInfo}) : super(key: key);

  @override
  _OrderSubmit createState() => _OrderSubmit();
}

class _OrderSubmit extends State<OrderSubmit> {
  Map<String, dynamic> serverKeyMap = {
    'serveProduct': '服务/商品',
    'chargeWay': '收费方式',
    'costType': '费用类型',
    'number': '数量',
    'price': '价格',
    'serviceName': '服务商',
    'subtotal': '小计',
  };

  bool isChooseDeal = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('订单确认'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowHeight: 36.0,
                headingRowColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.hovered))
                    return Theme.of(context)
                        .colorScheme
                        .primary
                        .withOpacity(0.08);
                  return Theme.of(context)
                      .dividerColor; // Use the default value.
                }),
                columnSpacing: 24.0,
                horizontalMargin: 20.0,
                columns: getColumns(),
                rows: getRows(),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '共  ',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12.0,
                              ),
                            ),
                            TextSpan(
                              text: '${widget.orderSubmitInfo.number}',
                              style: TextStyle(
                                color: Colors.red[400],
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: '  台',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${widget.orderSubmitInfo.summary} ${widget.orderSubmitInfo.currencyName}',
                  style: TextStyle(
                    color: Colors.red[400],
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 42.0,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Theme.of(context).dividerColor),
                    ),
                  ),
                  child: Row(
                    children: [
                      Checkbox(
                        value: isChooseDeal,
                        onChanged: (val) {
                          setState(() {
                            isChooseDeal = val;
                          });
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          getUserDeal();
                        },
                        child: Text(
                          '用户协议',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                highlightColor: Theme.of(context).primaryColorDark,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    "提交订单",
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ),
                onPressed: isChooseDeal ? submitOrder : null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<DataColumn> getColumns() {
    return serverKeyMap.values
        .map<DataColumn>((label) => DataColumn(
              label: Text(label),
            ))
        .toList();
  }

  List<DataRow> getRows() {
    return widget.orderSubmitInfo.serverList
        .map<DataRow>(
          (server) => DataRow(
            cells: [
              DataCell(Text(server.serveProduct)),
              DataCell(Text(server.chargeWay)),
              DataCell(Text(server.costType)),
              DataCell(Text(server.number)),
              DataCell(Text(server.price)),
              DataCell(Text(server.serviceName)),
              DataCell(Text(server.subtotal)),
            ],
          ),
        )
        .toList();
  }

  getUserDeal() async {
    try {
      EasyLoading.show();
      final response = await Utils.API.getDeal(3);
      final resp = Models.DealResponse.fromJson(response);
      if (resp.code != 200) return;

      Navigator.of(context).push(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) =>
              ContentPreview(title: '用户协议', content: resp.data?.content),
        ),
      );
    } finally {
      EasyLoading.dismiss();
    }
  }

  submitOrder() async {
    final response = await Utils.API.submitOrder(
      id: widget.orderSubmitInfo.id,
      number: widget.orderSubmitInfo.number,
    );
    final resp = Models.SubmitOrderResponse.fromJson(response);

    if (resp.code != 200) return;

    Navigator.of(context).popAndPushNamed(
      '/orderPayment',
      arguments: {
        'orderNumber': resp.data.orderNumber,
      },
    );
  }
}
