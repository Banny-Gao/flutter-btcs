import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../scopedModels/index.dart';
import '../../util/index.dart' as Utils;

import 'swiper.dart' as S;

class HomePage extends StatefulWidget {
  HomePage({Key, key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> _imgList = [
    'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2877516247,37083492&fm=26&gp=0.jpg',
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1582796218195&di=04ce93c4ac826e19067e71f916cec5d8&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2F344fda8b47808261c946c81645bff489c008326f15140-koiNr3_fw658'
  ];

  @override
  void initState() {
    super.initState();

    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(builder: (context, child, model) {
      return ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Padding(
              padding: EdgeInsets.only(
                top: 10.0,
                left: 10.0,
                right: 10.0,
                bottom: 10.0,
              ),
              child: S.Swiper(),
            ),
          )
        ],
      );
    });
  }

  @override
  void dispose() {
    EasyLoading.dismiss();
    super.dispose();
  }

  _getData() {
    print('get data');
  }

  getSlides() async {
    final response = await Utils.API.getSlides();
    print(response.toString());
  }
}
