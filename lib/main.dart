import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/entity/index.dart';
import 'package:flutter_wanandroid/helper/PageHelper.dart';
import 'package:flutter_wanandroid/helper/index.dart';
import 'package:flutter_wanandroid/pages/Index.dart';
import 'package:flutter_wanandroid/pages/index.dart';

void main() => runApp(new MyApp());

class Page {
  final String title;
  final Icon icon;
  final Widget page;

  const Page(this.title, this.icon, this.page);
}

final PageHelper<TreeEntity> _knowHelper = new PageHelper();
final PageHelper<NaviData> _naviHelper = new PageHelper();
final PageHelper<ProjectData> _projectHelper = new PageHelper();

final List<Page> tabs = [
  const Page("首页", const Icon(Icons.home), const HomePage()),
  new Page("知识体系", const Icon(Icons.book), new KnowledgePage(_knowHelper)),
  new Page("网站导航", const Icon(Icons.bookmark_border), new NaviPage(_naviHelper)),
  new Page("项目", const Icon(Icons.apps), new ProjectPage(_projectHelper)),
];

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => new _MyApp();
}

class _MyApp extends StatefulWidget {
  @override
  __MyAppState createState() => new __MyAppState();
}

class __MyAppState extends State<_MyApp> with NavigatorHelper {
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

  search(BuildContext context) {
    push(context, new SearchIndexPage());
  }
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
    super.initState();
  }

  @override
  void dispose() {
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
