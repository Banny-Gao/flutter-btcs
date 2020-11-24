import 'package:flutter/material.dart';
import 'scoped_models/app_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'widgets/utilviews/toggle_theme_widget.dart';

class CinematicApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (context, child, model) => MaterialApp(
        title: 'Ore',
        theme: model.theme,
        home: App(),
      ),
    );
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          ToggleThemeButton(),
        ],
        title: Text("Cinematic"),
      ),
      body: PageView(
        children: [],
        pageSnapping: true,
        controller: _pageController,
        onPageChanged: (int index) {
          setState(() {
            _page = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _getNavBarItems(),
        onTap: _navigationTapped,
        currentIndex: _page,
      ),
    );
  }

  List<BottomNavigationBarItem> _getNavBarItems() {
    return [
      BottomNavigationBarItem(
          icon: Icon(Icons.thumb_up), title: Text('Popular')),
      BottomNavigationBarItem(
          icon: Icon(Icons.live_tv), title: Text('On The Air')),
      BottomNavigationBarItem(icon: Icon(Icons.star), title: Text('Top Rated')),
    ];
  }

  List<Widget> _getMediaList() {
    return <Widget>[];
  }

  void _navigationTapped(int page) {
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

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
}
