import 'dart:math';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../routes.dart';
import '../../scopedModels/index.dart';
import '../../models/index.dart' as Models;
import '../../util/index.dart' as Utils;

import 'stickyTabBarDelegate.dart';
import 'groupCheckOutCount.dart';
import '../orders/orderSubmit.dart';

class Groups extends StatefulWidget {
  Groups({Key key}) : super(key: key);

  @override
  _GroupsState createState() => _GroupsState();
}

class _GroupsState extends State<Groups>
    with
        AutomaticKeepAliveClientMixin,
        SingleTickerProviderStateMixin,
        RouteAware {
  final num pageSize = 10;

  List<Models.Coin> tabs = AppModel.coinList;
  List tabGroups;

  int selectedIndex = 0;

  TabController _tabController;

  Timer _timer;
  List<Function> timerFns = [];

  double gridChildWidth;
  double gridChildHeight;
  double gridVerticalPadding;
  double childAspectRatio = 2;

  get wantKeepAlive => true;

  @override
  void initState() {
    if (tabs.length == 0) return;

    tabGroups = tabs.map((tab) => List<Models.Group>()).toList();

    _tabController = TabController(
      length: tabs.length,
      vsync: this,
    );

    _tabController.addListener(() {
      final index = _tabController.index;
      if (mounted) setState(() => selectedIndex = index);

      if (tabGroups[index].length == 0) _getData();
    });

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
    _tabController.dispose();

    if (_timer != null) {
      _timer.cancel();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void didPopNext() {
    _getData();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    gridChildWidth = MediaQuery.of(context).size.width - 10;
    gridChildHeight = gridChildWidth / childAspectRatio;
    gridVerticalPadding = gridChildHeight / 140;

    return ScopedModelDescendant<AppModel>(builder: (context, child, model) {
      return Scaffold(
        appBar: AppBar(
          title: Text('拼团活动'),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: true,
              delegate: StickyTabBarDelegate(
                // expandedHeight: 160.0,
                // coverImgUrl:
                //     'https://cdn.pixabay.com/photo/2020/12/12/20/15/waves-5826473__340.jpg',
                child: TabBar(
                  isScrollable: true,
                  labelColor: Colors.black,
                  controller: _tabController,
                  tabs: tabs
                      .map<Widget>(
                        (coin) => Tab(
                          icon: coin.iconPath != null
                              ? Image.network(
                                  coin.iconPath,
                                  width: 24.0,
                                  height: 24.0,
                                  fit: BoxFit.fill,
                                )
                              : Icon(
                                  FontAwesomeIcons.btc,
                                  color: Colors.primaries[Random().nextInt(17) %
                                      Colors.primaries.length],
                                ),
                          child: Text(coin.currencyName),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            SliverFillRemaining(
              child: TabBarView(
                controller: _tabController,
                children: getTabViews(),
              ),
            ),
          ],
        ),
      );
    });
  }

  _getData() async {
    final coin = tabs[selectedIndex];

    EasyLoading.show();
    try {
      final response = await Utils.API.getGroups(currencyId: coin.currencyId);
      final resp = Models.GroupsResponse.fromJson(response);

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

      if (mounted) {
        setState(() {
          tabGroups[selectedIndex] = resp.data;

          timerFns.addAll(resp.data.map<Function>((group) => () {
                setState(() {
                  group.countDownTime -= 1000;
                });
              }));
        });
      }
    } catch (error) {
      EasyLoading.showError(error.message);
    } finally {
      EasyLoading.dismiss();
    }
  }

  List<Widget> getTabViews() => tabGroups
      .map<Widget>(
        (tabGroup) => RefreshIndicator(
          onRefresh: () async {
            _getData();
          },
          child: GridView.custom(
            // padding: EdgeInsets.all(10.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: childAspectRatio,
              mainAxisSpacing: 5.0,
            ),
            childrenDelegate: SliverChildBuilderDelegate(
              (BuildContext context, index) => buildGridItem(tabGroup[index]),
              childCount: tabGroup.length,
            ),
          ),
        ),
      )
      .toList();

  Widget buildGridItem(Models.Group group) {
    final Map<String, dynamic> map = {
      '矿场名称': group.mineFieldName,
      '机器型号': group.lcd,
      // '周期': '${group.activityDay}天',
      // '托管模式': group.carePattern,
      // '每日电费': group.electricMoney,
      '算力': '${group.hashrate}TH/s',
      // '管理费用比例(%)': group.manageFee,
      // '拼团总共台数': group.platformTotal,
      '功耗:': '${group.power}W',
      // '已出售台数': group.sellPlatform,
      // '分期期数': group.stagingTime,
      // '分期付款比例': group.theRatio,
      '静态收益': '${group.yieldOutput} ${group.currencyName}/天(参考值)',
    };

    List<Widget> children = <Widget>[
      Padding(
        padding: EdgeInsets.fromLTRB(10.0, gridVerticalPadding, 10.0, 0),
        child: Text(
          group.groupName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: gridChildHeight / 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      Expanded(child: Container()),
    ];
    children.addAll(
      map.keys.map<Widget>(
        (key) => Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, gridVerticalPadding),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  '$key',
                  style: TextStyle(
                    fontSize: gridChildHeight / 20,
                    color: Colors.black45,
                  ),
                ),
              ),
              Text(
                '${map[key]}',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: gridChildHeight / 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    children.addAll([
      buildSold(group),
      buildGroupState(group.groupState, group.countDownTime),
      buildGroupCheckout(group),
    ]);

    return Card(
      child: Row(children: [
        // Container(
        //   width: MediaQuery.of(context).size.width * 0.4,
        //   child: Stack(
        //     fit: StackFit.expand,
        //     children: [
        //       Hero(
        //         tag: group.id,
        //         child: Image.network(group.producImg, fit: BoxFit.fitWidth),
        //       ),
        //       Material(
        //         type: MaterialType.transparency,
        //         child: InkWell(
        //           onTap: () {
        //             Navigator.of(context).pushNamed(
        //               '/group',
        //               arguments: {
        //                 'id': group.id,
        //               },
        //             );
        //           },
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        Expanded(
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(
                '/group',
                arguments: {
                  'id': group.id,
                },
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ),
      ]),
    );
  }

  Widget buildGroupState(state, countDownTime) {
    TextStyle basicStyle = TextStyle(
      fontSize: gridChildHeight / 18,
      color: Colors.black45,
    );
    TextStyle activeStyle = TextStyle(
      fontSize: gridChildHeight / 20,
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
          Utils.constructTime(countDownTime ~/ 1000),
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
            padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
            child: Align(
              child: Text(
                Utils.GroupState[state - 1],
                style: TextStyle(
                  fontSize: gridChildHeight / 18,
                  color: Colors.black45,
                ),
              ),
            ),
          ),
        );
        component = Container();
        break;
    }
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: gridChildHeight / 20,
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: Row(
          children: [
            Expanded(
              child: label,
            ),
            component,
          ],
        ),
      ),
    );
  }

  Widget buildGroupCheckout(Models.Group group) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
      child: Row(children: [
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${group.realityMoney} USDT',
                  style: TextStyle(
                    fontSize: gridChildHeight / 20,
                    color: Colors.black45,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                TextSpan(
                  text: ' ${group.discountMoney} USDT',
                  style: TextStyle(
                    color: Colors.red[400],
                    fontSize: gridChildHeight / 18,
                  ),
                ),
              ],
            ),
          ),
        ),
        IconButton(
          icon: Icon(FontAwesomeIcons.users),
          color: Colors.red[400],
          iconSize: gridChildHeight / 17,
          tooltip: '立即拼团',
          padding: EdgeInsets.all(0),
          onPressed: group.groupState == 2
              ? () {
                  checkoutGroup(group);
                }
              : null,
        ),
      ]),
    );
  }

  Widget buildSold(Models.Group group) {
    final double soldPercent = double.parse(
        (group.sellPlatform / group.platformTotal).toStringAsFixed(2));

    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, gridChildHeight / 20),
      child: group.groupState != 1
          ? Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: soldPercent,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red[400]),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    '已售${soldPercent * 100}%',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: gridChildHeight / 20,
                    ),
                  ),
                ),
              ],
            )
          : Container(),
    );
  }

  checkoutGroup(group) async {
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
