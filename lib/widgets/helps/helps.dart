import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../scopedModels/index.dart';
import '../../models/index.dart' as Models;
import '../../util/index.dart' as Utils;

class Helps extends StatefulWidget {
  final id;
  final title;
  Helps({
    Key key,
    this.id,
    this.title,
  }) : super(key: key);

  @override
  _Helps createState() => _Helps();
}

class _Helps extends State<Helps> {
  final num pageSize = 10;
  num pageNum = 1;
  bool isCompleted = false;
  bool isLoading = false;

  List<Models.Help> helps = [];

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
          title: Text(widget.title),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            pageNum = 1;
            helps = [];
            _getData();
          },
          child: ListView.builder(
            controller: _scrollController,
            itemCount: helps.length + 1,
            itemBuilder: buildListItem,
          ),
        ),
      ),
    );
  }

  Widget buildListItem(BuildContext context, index) {
    if (index == helps.length) {
      return isCompleted
          ? Container(
              height: 50.0,
              alignment: Alignment.center,
              padding: EdgeInsets.all(16.0),
              child: Text(
                "没有更多了",
                style: TextStyle(color: Colors.grey),
              ),
            )
          : Container();
    }
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            '/contentPreview',
            arguments: {
              'title': helps[index].title,
              'content': helps[index].content,
            },
          );
        },
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  helps[index].title,
                  style: TextStyle(
                    color: Theme.of(context).hintColor,
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
      ),
    );
  }

  _getData() async {
    EasyLoading.show();
    try {
      await _getHelps();
    } finally {
      EasyLoading.dismiss();
    }
  }

  _getHelps() async {
    final response = await Utils.API.getHelps(
      pageNum: pageNum,
      pageSize: pageSize,
      helpClassifyId: widget.id,
    );
    final resp = Models.HelpsResponse.fromJson(response);

    if (resp.code != 200) return;

    List<Models.Help> list = resp.data.list;
    if (list.length != 0) {
      Iterable<Models.Help> more = helps.followedBy(list);
      if (mounted)
        setState(() {
          helps = more.toList();
        });
    } else {
      if (mounted)
        setState(() {
          isCompleted = true;
        });
    }
  }
}
