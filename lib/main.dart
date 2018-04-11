import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/pages/HomePage.dart';
import 'package:flutter_wanandroid/pages/KnowledgePage.dart';
import 'package:flutter_wanandroid/pages/NaviPage.dart';
import 'package:flutter_wanandroid/pages/ProjectPage.dart';

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
      ),
      home: new MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var tabbar = new TabBar(
//      labelColor: Colors.blue,
//      unselectedLabelColor: Colors.white,
      tabs: tabs.map((Page page) {
        return new Tab(
          text: page.title,
          icon: page.icon,
        );
      }).toList(),
      indicator: new BoxDecoration(
//        color: Colors.white,
          ),
    );

    var page = new Scaffold(
      bottomNavigationBar: new BottomAppBar(
        child: tabbar,
        color: Colors.blue,
      ),
      body: new TabBarView(
        children: tabs.map((Page page) {
          return page.page;
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
