import 'dart:math';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../scopedModels/index.dart';
import '../../models/index.dart' as Models;
import '../../util/index.dart' as Utils;

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;
  final String coverImgUrl;
  final double collapsedHeight;
  final double expandedHeight;

  StickyTabBarDelegate({
    @required this.child,
    this.coverImgUrl,
    this.collapsedHeight = 0,
    this.expandedHeight = 0,
  });

  @override
  double get maxExtent => child.preferredSize.height + expandedHeight;

  @override
  double get minExtent => child.preferredSize.height + collapsedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  Color makeStickyHeaderBgColor(shrinkOffset) {
    final int alpha =
        (shrinkOffset / (maxExtent - minExtent) * 255).clamp(0, 255).toInt();
    return Color.fromARGB(alpha, 255, 255, 255);
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: maxExtent,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        // fit: StackFit.expand,
        children: <Widget>[
          coverImgUrl != null
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: expandedHeight,
                  child: Image.network(
                    coverImgUrl,
                    fit: BoxFit.fill,
                  ),
                )
              : Container(),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: makeStickyHeaderBgColor(shrinkOffset),
              child: this.child,
            ),
          ),
        ],
      ),
    );
  }
}

class Groups extends StatefulWidget {
  Groups({Key key}) : super(key: key);

  @override
  _GroupsState createState() => _GroupsState();
}

class _GroupsState extends State<Groups>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  final num pageSize = 10;

  List<Models.Coin> tabs = AppModel.coinList;
  List tabGroups;

  int selectedIndex = 0;

  TabController _tabController;

  Timer _timer;
  List<Function> timerFns = [];

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
      setState(() => selectedIndex = index);

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
  // ignore: must_call_super
  Widget build(BuildContext context) {
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
                //     'https://cdn.pixabay.com/photo/2019/09/06/17/04/china-4456845__340.jpg',
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

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();

    if (_timer != null) {
      _timer.cancel();
    }
  }

  List<Widget> getTabViews() => tabGroups
      .map<Widget>(
        (tabGroup) => RefreshIndicator(
          onRefresh: () async {
            _getData();
          },
          child: GridView.custom(
            cacheExtent: 200.0,
            padding: EdgeInsets.all(10.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.4,
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
      '挖矿天数': group.activityDay,
      // '托管模式': group.carePattern,
      // '每日电费': group.electricMoney,
      '算力': group.hashrate,
      '机器型号': group.lcd,
      '矿场运维名称': group.mineFieldName,
      // '管理费用比例(%)': group.manageFee,
      // '拼团总共台数': group.platformTotal,
      '机器功耗W:': group.power,
      // '已出售台数': group.sellPlatform,
      // '分期期数': group.stagingTime,
      // '分期付款比例': group.theRatio,
      '每日大约生产值(参考值)': group.yieldOutput,
    };

    var children = <Widget>[
      Container(
        height: 120.0,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Hero(
              tag: group.id,
              child: Image.network(group.producImg, fit: BoxFit.fill),
            ),
            Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
      Divider(height: 0),
      Padding(
        padding: EdgeInsets.all(8.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 48.0,
          ),
          child: Text(
            group.groupName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      Expanded(child: Container()),
    ];
    children.addAll(
      map.keys.map<Widget>(
        (key) => Padding(
          padding:
              EdgeInsets.only(left: 10.0, right: 10.0, top: 6.0, bottom: 6.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  '$key',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.black45,
                  ),
                ),
              ),
              Text(
                '${map[key]}',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    children.addAll([
      getGroupState(group.groupState, group.countDownTime),
    ]);

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  _getData() async {
    final coin = tabs[selectedIndex];

    EasyLoading.show();
    try {
      final response = await Utils.API.getGroups(currencyId: coin.currencyId);
      final resp = Models.GroupsResponse.fromJson(response);

      if (resp.code != 200) throw resp;

      setState(() {
        tabGroups[selectedIndex] = resp.data;

        timerFns.addAll(resp.data.map<Function>((group) => () {
              setState(() {
                group.countDownTime -= 1000;
              });
            }));
      });
    } catch (error) {
      EasyLoading.showError(error.message);
    } finally {
      EasyLoading.dismiss();
    }
  }

  String constructTime(int seconds) {
    int day = seconds ~/ 3600 ~/ 24;
    int hour = seconds ~/ 3600 % 24;
    int minute = seconds % 3600 ~/ 60;
    int second = seconds % 60;
    return formatTime(day, '天') +
        formatTime(hour, '小时', true) +
        formatTime(minute, '分', true) +
        formatTime(second, '秒', true);
  }

  String formatTime(int timeNum, String unit, [bool showUnit = false]) =>
      timeNum != 0 || showUnit ? timeNum.toString() + unit : '';

  Widget getGroupState(state, countDownTime) {
    TextStyle basicStyle = TextStyle(
      fontSize: 10.0,
      color: Colors.black45,
    );
    TextStyle activeStyle = TextStyle(
      fontSize: 12.0,
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
          constructTime(countDownTime ~/ 1000),
          style: activeStyle,
        );
        break;
      case 3:
      case 4:
        component = Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.0),
            border: Border.all(color: Colors.grey[400]),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 2.0),
            child: Text(
              Utils.GroupState[state - 1],
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey[400],
              ),
            ),
          ),
        );
        label = Container();
        break;
    }
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
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
}
