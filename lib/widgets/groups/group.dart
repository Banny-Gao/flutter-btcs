import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_collapse/flutter_collapse.dart';

import '../../routes.dart';
import '../../models/index.dart' as Models;
import '../../util/index.dart' as Utils;

import 'groupCheckOutCount.dart';
import '../orders/orderSubmit.dart';

// ignore: must_be_immutable
class Group extends StatefulWidget {
  num id;
  Group({Key key, @required this.id}) : super(key: key);

  @override
  _GroupState createState() => _GroupState();
}

class _GroupState extends State<Group> with RouteAware {
  Models.Group group = new Models.Group();
  int _tab = 0;

  Timer _timer;
  List<Function> timerFns = [];
  bool isLoaded = false;
  bool isBasicInfoExpanded = false;
  bool isGroupProtocolExpanded = false;
  bool isRiskProtocolExpanded = false;

  List<Models.Help> helps = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      _getData();
      _getHelps();
    });

    final call = (timer) {
      timerFns.forEach((fn) {
        fn();
      });
    };
    _timer = Timer.periodic(Duration(seconds: 1), call);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('拼团详情'),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            buildInfos(),
            buildAction(),
          ],
        ),
      ),
    );
  }

  Widget buildAction() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '拼团成功${group.miningBeginNumber}日左右上架开机',
                  style: TextStyle(fontSize: 12.0, color: Colors.black54),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 10.0, top: 2.0),
                      child: Text(
                        '首年0息0管理费',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '拼团价${group.realityMoney} USDT',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.red[400],
                          fontSize: 13.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        RaisedButton(
          color: Theme.of(context).primaryColor,
          highlightColor: Theme.of(context).primaryColorDark,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 20.0,
            ),
            child: Text(
              "立即拼团",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
          onPressed: group.groupState == 2
              ? () {
                  checkoutGroup();
                }
              : null,
        ),
      ],
    );
  }

  Widget buildInfos() {
    return Expanded(
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 50,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200.0,
                child: Hero(
                  tag: widget.id,
                  child: group.producImg != null
                      ? Image.network(
                          '${group.producImg}',
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.topCenter,
                        )
                      : Container(),
                ),
              ),
              group.groupName != null
                  ? Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        group.groupName,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  : Container(),
              group.countDownTime != null ? buildGroupState() : Container(),
              Divider(),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 6.0),
                      child: Icon(
                        FontAwesomeIcons.gripVertical,
                        size: 16.0,
                        color: Colors.red[400],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '拼团贷购信息',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              buildGroupItem(),
              Collapse(
                title: Container(child: Text('基础信息')),
                body: Column(
                  children: [
                    Html(data: group.millInfo),
                    Html(data: group.mineral),
                    Html(data: group.sampleInfo),
                  ],
                ),
                value: isBasicInfoExpanded,
                onChange: (bool value) {
                  setState(() {
                    isBasicInfoExpanded = value;
                  });
                },
              ),
              Collapse(
                title: Container(child: Text('拼团说明')),
                body: Column(
                  children: [
                    Html(data: group.groupProtocol),
                  ],
                ),
                value: isGroupProtocolExpanded,
                onChange: (bool value) {
                  setState(() {
                    isGroupProtocolExpanded = value;
                  });
                },
              ),
              Collapse(
                title: Container(child: Text('风险说明')),
                body: Column(
                  children: [
                    Html(data: group.riskProtocol),
                  ],
                ),
                value: isRiskProtocolExpanded,
                onChange: (bool value) {
                  setState(() {
                    isRiskProtocolExpanded = value;
                  });
                },
              ),
              helps.length != 0
                  ? Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 6.0),
                            child: Icon(
                              FontAwesomeIcons.gripVertical,
                              size: 16.0,
                              color: Colors.red[400],
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '常见问题',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
              helps.length != 0
                  ? Column(
                      children: helps
                          .map<Widget>(
                            (help) => Column(
                              children: [
                                InkWell(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 5.0,
                                      horizontal: 20.0,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            help.title,
                                            style: TextStyle(
                                              color:
                                                  Theme.of(context).hintColor,
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          FontAwesomeIcons.chevronRight,
                                          size: 12.0,
                                          color: Colors.grey[400],
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      '/contentPreview',
                                      arguments: {
                                        'title': help.title,
                                        'content': help.content,
                                      },
                                    );
                                  },
                                ),
                                Divider(),
                              ],
                            ),
                          )
                          .toList(),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildGroupItem() {
    final Map<String, dynamic> map = {
      '机器型号': group.lcd,
      '成团数量': '${group.platformTotal}台',
      '剩余台数': '${group.platformTotal - group.sellPlatform}台',
      '矿机贷款首付': '${group.theRatio}%',
      '分期付款周期': '${group.stagingTime}/月',
      '每期还款本金': '${group.stagingMoney}USDT/月/台',
      '托管矿位租金': '${group.electricMoney}USDT/月/台',
      '管理费用比例': '${group.manageFee}%',
      '每期还款利息': '${group.stagingRate}%',
    };

    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Column(
        children: map.keys
            .map<Widget>(
              (key) => Padding(
                padding: EdgeInsets.fromLTRB(10.0, 6.0, 10.0, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '$key',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    Text(
                      '${map[key]}',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget buildGroupState() {
    final state = group.groupState;

    TextStyle basicStyle = TextStyle(
      fontSize: 14.0,
      color: Colors.black45,
    );
    TextStyle activeStyle = TextStyle(
      fontSize: 14.0,
      color: Colors.red[400],
    );

    Widget component = Container();
    Widget label = Text(
      Utils.GroupState[state - 1],
      style: basicStyle,
    );

    switch (state) {
      case 1:
      case 2:
        component = Text(
          Utils.constructTime(group.countDownTime ~/ 1000),
          style: activeStyle,
        );
        break;
      case 3:
      case 4:
        label = Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: Colors.black45),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 10.0),
            child: Align(
              child: Text(
                Utils.GroupState[state - 1],
                style: basicStyle,
              ),
            ),
          ),
        );
        component = Container();
        break;
    }
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
      child: Row(
        children: [
          Expanded(
            child: label,
          ),
          component,
        ],
      ),
    );
  }

  _getData() async {
    EasyLoading.show();
    try {
      final response = await Utils.API.getGroup(id: widget.id);
      final resp = Models.GroupResponse.fromJson(response);

      if (resp.code != 200) return;

      if (mounted)
        setState(() {
          group = resp.data;
          timerFns.add(() => () {
                setState(() {
                  group.countDownTime -= 1000;
                });
              });
        });
    } finally {
      EasyLoading.dismiss();
      setState(() {
        isLoaded = true;
      });
    }
  }

  checkoutGroup() async {
    num max = group.platformTotal - group.sellPlatform;
    int result = await showDialog(
      context: context,
      builder: (context) {
        bool useSlider = true;
        double sliderValue = 1;

        int textNumber = 1;
        Timer timer;
        TextEditingController textController = TextEditingController();
        textController.text = '1';

        return groupCheckOutCount(
          useSlider: useSlider,
          sliderValue: sliderValue,
          textNumber: textNumber,
          timer: timer,
          textController: textController,
          max: max,
        );
      },
    );
    if (result == null) return;

    EasyLoading.show();
    try {
      final response = await Utils.API.submitGroup(
        id: group.id,
        number: result,
      );
      final resp = Models.SubmitGroupResponse.fromJson(response);
      if (resp.code != 200) return;

      final Models.SubmitGroupResponseData orderSubmitInfo = resp.data;

      Navigator.of(context).push(
        MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) =>
                OrderSubmit(orderSubmitInfo: orderSubmitInfo)),
      );
    } finally {
      EasyLoading.dismiss();
    }
  }

  _getHelps() async {
    final response = await Utils.API.getHelps(
      pageNum: 1,
      pageSize: 6,
      helpClassifyId: 1,
    );
    final resp = Models.HelpsResponse.fromJson(response);

    if (resp.code != 200) return;

    if (mounted)
      setState(() {
        helps = resp.data.list;
      });
  }
}
