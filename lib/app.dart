import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:webview_flutter/webview_flutter.dart';

import 'scopedModels/index.dart';

import 'widgets/index.dart';
import 'routes.dart';

// ignore: must_be_immutable
class OreApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (context, child, model) {
        setGlobalModelRequset(model);
        return MaterialApp(
          theme: model.theme,
          initialRoute: model.isLogin ? '/' : '/login',
          routes: routes,
          builder: EasyLoading.init(),
          navigatorKey: GlobalRoute.navigatorKey,
          navigatorObservers: [routeObserver],
        );
      },
    );
  }

  setGlobalModelRequset(model) async {
    await Future.delayed(Duration.zero);
    model.getCoins();
  }
}

class App extends StatefulWidget {
  @override
  State createState() => AppState();
}

class AppState extends State<App> {
  PageController _pageController;
  int _page = 0;

  @override
  void initState() {
    _pageController = PageController();
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(builder: (context, child, model) {
      return MediaQuery.removePadding(
        context: context,
        removeBottom: true,
        child: Scaffold(
          body: DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: PageView(
              children: _getMediaList(),
              pageSnapping: true,
              controller: _pageController,
              onPageChanged: _onPageChanged,
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: _getNavBarItems(),
            onTap: _navigationTapped,
            currentIndex: _page,
            selectedItemColor: Theme.of(context).primaryColorDark,
            unselectedItemColor: Theme.of(context).primaryColorLight,
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void _navigationTapped(int page) {
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void _onPageChanged(int index) {
    if (mounted)
      setState(() {
        _page = index;
      });
  }

  List<Widget> _getMediaList() {
    return <Widget>[
      Home(),
      Groups(),
      Assets(),
      Owner(),
    ];
  }

  List<BottomNavigationBarItem> _getNavBarItems() {
    return [
      BottomNavigationBarItem(
        icon: Icon(
          FontAwesomeIcons.home,
        ),
        label: '首页',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          FontAwesomeIcons.hamburger,
        ),
        label: '拼团',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          FontAwesomeIcons.dollarSign,
        ),
        label: '资产',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          FontAwesomeIcons.userTie,
        ),
        label: '我的',
      ),
    ];
  }
}
