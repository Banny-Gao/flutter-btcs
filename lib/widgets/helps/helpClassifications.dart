import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../scopedModels/index.dart';
import '../../models/index.dart' as Models;
import '../../util/index.dart' as Utils;

class HelpClassifications extends StatefulWidget {
  HelpClassifications({Key key}) : super(key: key);

  @override
  _HelpClassifications createState() => _HelpClassifications();
}

class _HelpClassifications extends State<HelpClassifications> {
  final num pageSize = 10;
  num pageNum = 1;
  bool isCompleted = false;
  bool isLoading = false;

  List<Models.HelpClassifications> helpClassifications = [];

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      _getData();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !isCompleted) {
        pageNum++;
        _getData();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (context, child, model) => Scaffold(
        appBar: AppBar(
          title: Text('帮助中心'),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            pageNum = 1;
            helpClassifications = [];
            _getData();
          },
          child: ListView.custom(
            controller: _scrollController,
            itemExtent: 140.0,
            childrenDelegate: SliverChildBuilderDelegate(
              (BuildContext context, index) => buildListItem(index),
              childCount: helpClassifications.length + 1,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildListItem(index) {
    if (index == helpClassifications.length) {
      return isCompleted
          ? Container(
              height: 50.0,
              alignment: Alignment.center,
              padding: EdgeInsets.all(16.0),
              child: Text(
                helpClassifications.length == 0 ? "暂无数据" : "没有更多了",
                style: TextStyle(color: Colors.grey),
              ),
            )
          : Container();
    }
    return Container(
      height: 140.0,
      child: Padding(
        padding: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          shadowColor: Theme.of(context).primaryColor,
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed('/helps', arguments: {
                'id': helpClassifications[index].id,
                'title': helpClassifications[index].classifyTitle,
              });
            },
            child: Center(
              child: Text(
                helpClassifications[index].classifyTitle,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).hintColor,
                ),
              ),
            ),
            // color: Colors.primaries[index % Colors.primaries.length],
          ),
        ),
      ),
    );
  }

  _getData() async {
    EasyLoading.show();
    try {
      await _getHelpClassifications();
    } finally {
      EasyLoading.dismiss();
    }
  }

  _getHelpClassifications() async {
    final response = await Utils.API.getHelpClassifications(
      pageNum: pageNum,
      pageSize: pageSize,
    );
    final resp = Models.HelpClassificationsResponse.fromJson(response);

    if (resp.code != 200) return;

    List<Models.HelpClassifications> list = resp.data.list;
    if (list.length != 0) {
      Iterable<Models.HelpClassifications> more =
          helpClassifications.followedBy(list);
      if (mounted)
        setState(() {
          helpClassifications = more.toList();
        });
    } else {
      if (mounted)
        setState(() {
          isCompleted = true;
        });
    }
  }
}
