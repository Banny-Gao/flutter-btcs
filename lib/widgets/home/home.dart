import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../scopedModels/index.dart';
import '../../models/index.dart' as Models;
import '../../util/index.dart' as Utils;
import '../../common/index.dart' as Common;

class Home extends StatefulWidget {
  Home({Key, key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Models.Slides> _imgList = [];
  List<Models.Bulletins> _bulletins = [];

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero).then((value) {
      _getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return ScopedModelDescendant<AppModel>(builder: (context, child, model) {
      return ListView(
        children: <Widget>[
          buildBanners(),
          buildBulletins(),
        ],
      );
    });
  }

  Widget buildBanners() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      height: 200.0,
      child: new Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(
              top: 10.0,
              bottom: 10.0,
              left: 20.0,
              right: 20.0,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black87,
                    offset: Offset(0.0, 4.0),
                    blurRadius: 6.0,
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: new Image.network(
                  "${_imgList[index].imageUrl}",
                  fit: BoxFit.fill,
                ),
              ),
            ),
          );
        },
        key: UniqueKey(),
        itemCount: _imgList.length,
        pagination: new SwiperPagination(),
        autoplay: true,
        // viewportFraction: 0.84,
        // scale: 0.9,
      ),
    );
  }

  Widget buildBulletins() {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      height: 40.0,
      child: Padding(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        child: new Swiper(
          itemBuilder: (BuildContext context, int index) {
            return Row(
              children: [
                Icon(
                  FontAwesomeIcons.gripLinesVertical,
                  color: Colors.blue[600],
                ),
                Flexible(
                  child: Text(
                    _bulletins[index].title,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            );
          },
          key: UniqueKey(),
          itemCount: _bulletins.length,
          autoplay: true,
          autoplayDelay: 5000,
          scrollDirection: Axis.vertical,
        ),
      ),
    );
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
      await _getBulletins();
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

  _getBulletins() async {
    final response = await Utils.API.getBulletins();
    final resp = Models.BulletinsResponse.fromJson(response);

    if (resp.code != 200) return;

    setState(() {
      _bulletins = resp.data?.list;
    });
  }
}
