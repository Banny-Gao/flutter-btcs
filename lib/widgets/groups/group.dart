import 'dart:math';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../routes.dart';
import '../../scopedModels/index.dart';
import '../../models/index.dart' as Models;
import '../../util/index.dart' as Utils;

import 'stickyTabBarDelegate.dart';
import 'groupCheckOutCount.dart';
import '../orders/orderSubmit.dart';

class Group extends StatefulWidget {
  Group({Key key}) : super(key: key);

  @override
  _GroupState createState() => _GroupState();
}

class _GroupState extends State<Group>
    with SingleTickerProviderStateMixin, RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
