import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../common/index.dart' as Common;
import '../../scopedModels/index.dart';
import '../../models/index.dart' as Models;
import '../../util/index.dart' as Utils;

class Owner extends StatefulWidget {
  Owner({Key key}) : super(key: key);
  @override
  _OwnerState createState() => _OwnerState();
}

class _OwnerState extends State<Owner> with AutomaticKeepAliveClientMixin {
  Models.User user = Models.User();

  List tabs = [
    {
      'title': '实名认证',
      'type': 'auth',
      'icon': FontAwesomeIcons.accessibleIcon,
    },
    {
      'title': '帮助中心',
      'type': 'link',
      'path': '/helps',
      'icon': FontAwesomeIcons.hireAHelper,
    },
    {
      'title': '钱包',
      'type': 'link',
      'path': '/walletAddresses',
      'icon': FontAwesomeIcons.wallet,
    },
    {
      'title': '修改登录密码',
      'type': 'link',
      'path': '/changePassword',
      'icon': FontAwesomeIcons.lock,
    },
    {
      'title': '修改支付密码',
      'type': 'link',
      'path': '/changePaymentPassword',
      'icon': FontAwesomeIcons.lock,
    },
    {
      'title': '修改手机号',
      'type': 'link',
      'path': '/changePhone',
      'icon': FontAwesomeIcons.phone,
    },
    {
      'title': '公司简介',
      'type': 'about',
      'icon': FontAwesomeIcons.smileWink,
    },
  ];

  get wantKeepAlive => true;

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
      return CustomScrollView(
        reverse: false,
        shrinkWrap: false,
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 160.0,
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.transparent),
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: [StretchMode.blurBackground],
              background: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(0)),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Common.Colors.blueGradientStart,
                        Common.Colors.blueGradientEnd,
                      ],
                    ),
                  ),
                  child: InkWell(
                    highlightColor: Colors.white24,
                    onTap: () {
                      Navigator.of(context).pushNamed('/editUser');
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _buildAvatar(),
                        user.inviteCode != null
                            ? Padding(
                                padding: EdgeInsets.only(left: 20.0, top: 16.0),
                                child: Text(
                                  '邀请码:    ${user.inviteCode}',
                                  style: TextStyle(
                                    color: Theme.of(context).hintColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.0,
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverFixedExtentList(
            itemExtent: 60.0,
            delegate: SliverChildBuilderDelegate((context, index) {
              // String title = titles[index];
              return _buildTab(index);
            }, childCount: tabs.length),
          ),
        ],
      );
    });
  }

  Widget _buildAvatar() {
    return Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 2.0,
              ),
              shape: BoxShape.circle,
              color: Colors.transparent,
              image: DecorationImage(
                image: user.memberAvatar == null
                    ? AssetImage("assets/img/avatar.png")
                    : NetworkImage(user.memberAvatar),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              user.memberName != null ? user.memberName : "游客",
              style: TextStyle(
                color: Theme.of(context).hintColor,
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(index) {
    final tab = tabs[index];
    final icon = tab['icon'];

    return Container(
      alignment: Alignment.centerLeft,
      child: InkWell(
        highlightColor: Theme.of(context).primaryColorLight,
        onTap: () {
          handleTab(index);
        },
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: 15.0,
                bottom: 15.0,
                left: 20.0,
                right: 20.0,
              ),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 12.0),
                    child: Icon(
                      icon,
                      size: 16.0,
                      color: Colors.primaries[index % Colors.primaries.length],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      tabs[index]['title'],
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  getTabRight(index),
                ],
              ),
            ),
            Divider(height: 1.0, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }

  getTabRight(index) {
    final tab = tabs[index];
    Widget component = Container();
    Widget icon = Icon(
      FontAwesomeIcons.chevronRight,
      size: 12.0,
      color: Colors.grey[400],
    );

    switch (tab['type']) {
      case 'auth':
        {
          String text = user.autoStatus != null
              ? ['未认证', '待审核', '审核拒绝', '已认证'][user.autoStatus]
              : '';
          component = Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Text(
                  text,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 12.0,
                  ),
                ),
              ),
              icon,
            ],
          );
        }
        break;
      case 'about':
      default:
        component = icon;
    }

    return component;
  }

  handleTab(index) {}

  _getData() async {
    EasyLoading.show();
    try {
      await _getUserInfo();
    } finally {
      EasyLoading.dismiss();
    }
  }

  _getUserInfo() async {
    final response = await Utils.API.getUserInfo();
    final resp = Models.UserInfoReponse.fromJson(response);

    if (resp.code != 200) return;

    ProfileModel.profile.user = resp.data;
    ProfileModel.holdProfile();

    setState(() {
      user = resp.data;
    });
  }
}
