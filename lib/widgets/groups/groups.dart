import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../scopedModels/index.dart';
import '../../models/index.dart' as Models;
import '../../util/index.dart' as Utils;

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  StickyTabBarDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return this.child;
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class Groups extends StatefulWidget {
  Groups({Key key}) : super(key: key);

  @override
  _Group createState() => _Group();
}

class _Group extends State<Groups>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  final num pageSize = 10;

  List groups = [];
  List tabs = AppModel.coinList;
  List tabViewQueries;

  int selectedIndex = 0;

  List<ScrollController> _scrollControllers;
  TabController _tabController;

  get wantKeepAlive => true;

  @override
  void initState() {
    if (tabs.length == 0) return;

    tabViewQueries = tabs
        .map((tab) => ({
              'pageNum': 1,
              'isCompleted': false,
              'isLoading': false,
            }))
        .toList();

    _scrollControllers =
        tabs.map<ScrollController>((tab) => new ScrollController()).toList();

    _scrollControllers.forEach((_scrollController) {
      final tabViewQuery = tabViewQueries[selectedIndex];
      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
                _scrollController.position.maxScrollExtent &&
            !tabViewQuery.isCompleted) {
          tabViewQuery.pageNum++;
          _getData();
        }
      });
    });

    _tabController = TabController(
      length: tabs.length,
      vsync: this,
    );

    _tabController.addListener(() {
      setState(() => selectedIndex = _tabController.index);
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
        body: RefreshIndicator(
          onRefresh: () async {
            _refreshGroups();
          },
          child: CustomScrollView(
            slivers: <Widget>[
              // SliverAppBar(
              //   pinned: true,
              //   elevation: 0,
              //   expandedHeight: 250,
              //   flexibleSpace: FlexibleSpaceBar(
              //     title: Text('Sliver-sticky效果'),
              //     background: Image.network(
              //       'http://img1.mukewang.com/5c18cf540001ac8206000338.jpg',
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              // ),
              SliverPersistentHeader(
                pinned: true,
                delegate: StickyTabBarDelegate(
                  child: TabBar(
                    isScrollable: true,
                    labelColor: Colors.black,
                    controller: _tabController,
                    tabs: tabs
                        .map<Widget>((coin) => Text(coin.currencyName))
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
        ),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _scrollControllers.forEach((_scrollController) {
      _scrollController.dispose();
    });
  }

  Widget buildGridItem(index) {}

  _refreshGroups() {}

  _getData() {}

  List<Widget> getTabViews() => tabs.map<Widget>((tab) {
        return GridView.custom(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          controller: _scrollControllers[selectedIndex],
          childrenDelegate: SliverChildBuilderDelegate(
            (BuildContext context, index) => buildGridItem(index),
            childCount: groups.length + 1,
          ),
        );
      }).toList();
}
