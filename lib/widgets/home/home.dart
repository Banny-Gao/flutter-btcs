import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../scopedModels/index.dart';
import '../../models/index.dart' as Models;
import '../../util/index.dart' as Utils;

class Home extends StatefulWidget {
  Home({Key, key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Models.Slides> _imgList = [];

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero).then((value) {
      _getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(builder: (context, child, model) {
      return ListView(
        children: <Widget>[
          Container(
            height: 230.0,
            child: new Swiper(
              itemBuilder: (BuildContext context, int index) {
                return new Image.network(
                  "${_imgList[index].imageUrl}",
                  fit: BoxFit.fill,
                );
              },
              itemCount: _imgList.length,
              pagination: new SwiperPagination(),
            ),
          ),
        ],
      );
    });
  }

  @override
  void dispose() {
    EasyLoading.dismiss();
    super.dispose();
  }

  _getData() async {
    EasyLoading.show();
    try {
      await _getSlides();
    } finally {
      EasyLoading.dismiss();
    }
  }

  _getSlides() async {
    final response = await Utils.API.getSlides();

    final resp = Models.SlidesResponse.fromJson(response);

    if (resp.code != 200) return;

    setState(() {
      _imgList = resp.data.list;
    });
  }
}
