import 'dart:math';

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
                expandedHeight: 160.0,
                coverImgUrl:
                    'https://cdn.pixabay.com/photo/2019/09/06/17/04/china-4456845__340.jpg',
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
  }

  List<Widget> getTabViews() => tabGroups
      .map<Widget>(
        (tabGroup) => RefreshIndicator(
          onRefresh: () async {
            _refreshGroups();
          },
          child: GridView.custom(
            padding: EdgeInsets.all(0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            childrenDelegate: SliverChildBuilderDelegate(
              (BuildContext context, index) => buildGridItem(index),
              childCount: tabGroup.length,
            ),
          ),
        ),
      )
      .toList();

  Widget buildGridItem(index) {
    return Container(
      height: 80.0,
      color: Colors.primaries[index % Colors.primaries.length],
    );
  }

  _refreshGroups() {}

  _getData() async {
    final coin = tabs[selectedIndex];

    EasyLoading.show();
    try {
      final response = await Utils.API.getGroups(currencyId: coin.currencyId);
      final resp = Models.GroupsResponse.fromJson(response);

      if (resp.code != 200) throw resp;

      setState(() {
        tabGroups[selectedIndex] = resp.data;
      });
    } catch (error) {
      EasyLoading.showError(error.message);
    } finally {
      EasyLoading.dismiss();
    }
  }
}
