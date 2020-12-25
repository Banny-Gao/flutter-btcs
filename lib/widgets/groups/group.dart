import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../routes.dart';
import '../../models/index.dart' as Models;
import '../../util/index.dart' as Utils;

import 'groupCheckOutCount.dart';
import '../orders/orderSubmit.dart';

class Group extends StatefulWidget {
  num id;
  Group({Key key, @required this.id}) : super(key: key);

  @override
  _GroupState createState() => _GroupState();
}

class _GroupState extends State<Group> with RouteAware {
  Models.Group group = new Models.Group();
  int _tab = 0;

  List<Map<String, dynamic>> tabs = [
    {'title': '拼团说明', 'content': ''},
    {'title': '风险说明', 'content': ''},
    {'title': '矿场信息', 'content': ''},
    {'title': '矿池信息', 'content': ''},
  ];

  Timer _timer;
  List<Function> timerFns = [];
  bool isLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      _getData();
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
        body: Column(
          children: [
            buildInfos(),
            buildAction(),
          ],
        ));
  }

  Widget buildAction() {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: Text(
            '原价${group.realityMoney} ${group.currencyName}',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 12.0,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ),
        Expanded(
          child: Text(
            '拼团价${group.realityMoney} ${group.currencyName}',
            style: TextStyle(
              color: Colors.red[400],
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
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
                        '拼团信息',
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
                        '矿机信息',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              group.millInfo != null ? Html(data: group.millInfo) : Container(),
              Divider(),
              Row(
                children: getPagesTab(),
              ),
              getPageViews()[_tab],
            ],
          ),
        ),
      ),
    );
  }

  Widget buildGroupItem() {
    final Map<String, dynamic> map = {
      '团购开始时间': group.beginTime,
      '团购结束时间': group.endTime,
      '矿场运维名称': group.mineFieldName,
      '机器型号': group.lcd,
      '周期': '${group.activityDay}天',
      '托管模式': group.carePattern,
      '每日电费': group.electricMoney,
      '算力': '${group.hashrate}TH/s',
      '管理费用比例(%)': group.manageFee,
      '拼团总共台数': group.platformTotal,
      '功耗:': '${group.power}W',
      '已出售台数': group.sellPlatform,
      '分期期数': group.stagingTime,
      '分期付款比例': group.theRatio,
      '静态收益': '${group.yieldOutput} ${group.currencyName}/天',
    };

    return Column(
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
                        color: Colors.black45,
                      ),
                    ),
                  ),
                  Text(
                    '${map[key]}',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  getPagesTab() {
    return tabs.map<Widget>(
      (info) {
        return Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _tab =
                    tabs.indexWhere((node) => node['title'] == info['title']);
              });
            },
            child: Text(
              info['title'],
              textAlign: TextAlign.center,
              style: TextStyle(
                color: tabs[_tab]['title'] == info['title']
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
            ),
          ),
        );
      },
    ).toList();
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
          tabs = [
            {'title': '拼团说明', 'content': group.groupProtocol},
            {'title': '风险说明', 'content': group.riskProtocol},
            {'title': '矿场信息', 'content': group.mineral},
            {'title': '矿池信息', 'content': group.sampleInfo},
          ];
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

  List<Widget> getPageViews() => tabs.map<Widget>(
        (tab) {
          return isLoaded
              ? Html(
                  data: Utils.getHtmlUrl(tab['title'], tab['content'],
                      parsed: false),
                )
              : Container();
        },
      ).toList();

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
}
