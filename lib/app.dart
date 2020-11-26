import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'scopedModels/index.dart';
import 'components/ToggleThemeButton.dart';

import 'widgets/widgets.dart';

class OreApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(builder: (context, child, model) {
      print(model);
      final String initialRoute = model.isLogin ? '/' : 'login';

      return MaterialApp(
        theme: model.theme,
        initialRoute: initialRoute,
        // localizationsDelegates: [
        //   // 本地化的代理类
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate,
        //   GmLocalizationsDelegate()
        // ],
        routes: <String, WidgetBuilder>{
          "/": (context) => App(),
          "login": (context) => Login(),
        },
      );
    });
  }
}

class App extends StatefulWidget {
  @override
  State createState() => AppState();
}

class AppState extends State<App> {
  PageController _pageController;
  int _page = 0;
  String _appBarTitle = 'ORE';

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
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
    setState(() {
      _page = index;
    });
  }

  List<Widget> _getMediaList() {
    return <Widget>[
      Home(),
      GroupBooking(),
      Owner(),
    ];
  }

  List<BottomNavigationBarItem> _getNavBarItems() {
    return [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
      BottomNavigationBarItem(
          icon: Icon(Icons.monetization_on_outlined), label: '拼团'),
      BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: '我的'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          ToggleThemeButton(),
        ],
        title: Text('$_appBarTitle'),
      ),
      body: PageView(
        children: _getMediaList(),
        pageSnapping: true,
        controller: _pageController,
        onPageChanged: _onPageChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _getNavBarItems(),
        onTap: _navigationTapped,
        currentIndex: _page,
      ),
    );
  }
}
