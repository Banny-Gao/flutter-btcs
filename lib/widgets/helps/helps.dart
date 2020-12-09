import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../scopedModels/index.dart';
import '../../common/index.dart' as Common;
import '../../models/index.dart' as Models;
import '../../util/index.dart' as Utils;

class Helps extends StatefulWidget {
  Helps({Key key}) : super(key: key);

  @override
  _Helps createState() => _Helps();
}

class _Helps extends State<Helps> {
  final num pageSize = 10;
  num pageNum = 1;
  bool isCompleted = false;

  List<Models.HelpClassifications> helpClassifications = [];

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      _getData();
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
        body: ListView(),
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
      final more = helpClassifications.followedBy(list);
      setState(() {
        helpClassifications = more;
      });
    } else {
      setState(() {
        isCompleted = true;
      });
    }
  }
}
