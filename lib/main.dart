import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/pages/main/HomePage.dart';
import 'package:flutter_wanandroid/pages/main/HotPage.dart';
import 'package:flutter_wanandroid/pages/main/KnowledgePage.dart';
import 'package:flutter_wanandroid/pages/main/NaviPage.dart';
import 'package:flutter_wanandroid/pages/main/ProjectPage.dart';
import 'package:flutter_wanandroid/pages/draw/DrawerPage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
        buttonTheme: new ButtonThemeData(textTheme: ButtonTextTheme.primary),
      ),
      home: new Scaffold(
          appBar: new AppBar(
            title: new Text('玩安卓flutter版'),
            actions: <Widget>[
              _buildAction(Icons.whatshot, hot),
              _buildAction(Icons.search, search),
            ],
          ),
          drawer: new DrawerPage(),
          body: new MainPage()),
    );
  }

  Widget _buildAction(IconData data, Function pressed) {
    return new Builder(builder: (ctx) {
      return new IconButton(
          icon: new Icon(data),
          onPressed: () {
            pressed(ctx);
          });
    });
  }

  hot(BuildContext context) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) {
      return new HotPage();
    }));
  }

  search(BuildContext context) {}
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() {
    return new _MainPageState();
  }
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  var map = new Map<Page, Widget>();

//  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    _tabController = new TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
//    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var tabbar = new TabBar(
      tabs: tabs.map((Page page) {
        return new Tab(
          text: page.title,
          icon: page.icon,
        );
      }).toList(),
      indicator: new BoxDecoration(),
    );

    var page = new Scaffold(
      bottomNavigationBar: new BottomAppBar(
        child: tabbar,
        color: Colors.blue,
      ),
      body: new TabBarView(
        children: tabs.map((Page page) {
          var widget = map[page];
          if (widget == null) {
            widget = page.page;
            map[page] = widget;
          }
          return widget;
        }).toList(),
      ),
    );

    return new DefaultTabController(length: tabs.length, child: page);
  }
}

class Page {
  final String title;
  final Icon icon;
  final Widget page;

  const Page(this.title, this.icon, this.page);
}

const List<Page> tabs = const <Page>[
  const Page("首页", const Icon(Icons.home), const HomePage()),
  const Page("知识体系", const Icon(Icons.book), const KnowledgePage()),
  const Page("导航", const Icon(Icons.bookmark_border), const NaviPage()),
  const Page("项目", const Icon(Icons.apps), const ProjectPage()),
];
