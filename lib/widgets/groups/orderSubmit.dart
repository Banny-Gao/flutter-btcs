import 'dart:collection';
import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../scopedModels/index.dart';
import '../../models/index.dart' as Models;
import '../../util/index.dart' as Utils;
import '../../common/index.dart' as Common;

// ignore: must_be_immutable
class OrderSubmit extends StatefulWidget {
  Models.SubmitGroupResponseData orderSubmitInfo;

  OrderSubmit({Key key, @required this.orderSubmitInfo}) : super(key: key);

  @override
  _OrderSubmit createState() => _OrderSubmit();
}

class _OrderSubmit extends State<OrderSubmit> {
  Map<String, dynamic> serverKeyMap = {
    'chargeWay': '收费方式',
    'costType': '费用类型',
    'number': '数量',
    'price': '价格',
    'serveProduct': '服务/商品',
    'serviceName': '服务商',
    'subtotal': '小计',
  };

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
                horizontalMargin: 10.0,
                columns: getColumns(),
                rows: getRows(),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 47.0,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Theme.of(context).dividerColor),
                    ),
                  ),
                  child: Row(),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: Common.Colors.blueGradient,
                ),
                child: MaterialButton(
                  highlightColor: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: Text(
                      "提交订单",
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),
                  onPressed: () {},
                ),
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
              DataCell(Text(server.chargeWay)),
              DataCell(Text(server.costType)),
              DataCell(Text(server.number)),
              DataCell(Text(server.price)),
              DataCell(Text(server.serveProduct)),
              DataCell(Text(server.serviceName)),
              DataCell(Text(server.subtotal)),
            ],
          ),
        )
        .toList();
  }
}
