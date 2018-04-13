import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/entity/HomeEntity.dart';
import 'package:flutter_wanandroid/pages/WebPage.dart';
import 'package:flutter_wanandroid/pages/draw/DrawerPage.dart';
import 'package:flutter_wanandroid/widget/LoadMore.dart';

var httpClient = new HttpClient();

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('首页'),
      ),
      drawer: new DrawPage(),
      body: new HomeList(),
    );
  }

  const HomePage();
}

class HomeList extends StatefulWidget {
  @override
  _HomeListState createState() => new _HomeListState();
}

class _HomeListState extends State<HomeList> with WebPage, TickerProviderStateMixin {
  int page = 0;
  List<HomeData> list = new List();
  var isRefresh = false;
  var isLoadMore = false;

  List<HomeBannerData> bannerList = new List();

  TabController _bannerController;

  @override
  void initState() {
    super.initState();
    _loadData(0);
    _loadBanner();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _bannerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var content = new RefreshIndicator(
        child: new LoadMoreWidget(
          onLoadMore: loadmore,
          listView: new ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: _buildItem,
            itemCount: list.length + 1,
          ),
        ),
        onRefresh: _refresh);
    return content;
  }

  Widget _buildBanner() {
    if (_bannerController != null) {
      _bannerController.dispose();
    }
    _bannerController = new TabController(vsync: this, length: bannerList.length);

    return new AspectRatio(
      aspectRatio: 3 / 1.7,
      child: new TabBarView(
        children: bannerList.map(_buildBannerItem).toList(),
        controller: _bannerController,
      ),
    );
  }

  Widget _buildBannerItem(HomeBannerData data) {
    var color = new Color(Colors.black.value).withAlpha(88);

//    var data = bannerList[index];
    return new InkWell(
      child: new Stack(children: <Widget>[
        new Image.network(
          data.imagePath,
          fit: BoxFit.fitWidth,
        ),
        new Align(
          child: new SizedBox(
            height: 30.0,
            child: new Scaffold(
              backgroundColor: color,
              body: new Center(
                child: new Text(
                  data.title,
                  style: new TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          alignment: Alignment.bottomCenter,
        ),
      ]),
      onTap: () {
        startUrl(data.url);
      },
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    if (index == 0) {
      return _buildBanner();
    }

    var data = list[index - 1];
    return new ListTile(
      title: new Text(data.title),
      subtitle: new Text("作者:${data.author}"),
      onTap: () {
        startUrl(data.link);
      },
    );
  }

  void _loadData(int page) async {
    var uri = new Uri.http("www.wanandroid.com", "article/list/$page/json");
    var request = await httpClient.getUrl(uri);
    var response = await request.close();
    var json = await response.transform(UTF8.decoder).join();

    Map userMap = JSON.decode(json);
    var resp = new HomeEntity.fromJson(userMap);

    var curPage = resp.data.curPage;
    if (curPage == 1) {
      this.page = 0;
      list.clear();
    }
    list.addAll(resp.data.datas);
    isLoadMore = false;
    isRefresh = false;
    this.page++;
    setState(() {});
  }

  Future<Null> _refresh() async {
    _loadData(0);
  }

  Future<Null> loadmore() async {
    _loadData(page);
  }

  void _loadBanner() async {
    var uri = new Uri.http("www.wanandroid.com", "banner/json");
    var request = await httpClient.getUrl(uri);
    var response = await request.close();
    var json = await response.transform(UTF8.decoder).join();

    Map userMap = JSON.decode(json);
    var resp = new HomeBannerEntity.fromJson(userMap);

    bannerList.clear();
    bannerList.addAll(resp.data);
    setState(() {});
  }
}
