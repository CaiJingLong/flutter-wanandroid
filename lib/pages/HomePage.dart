import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/entity/HomeEntity.dart';
import 'package:flutter_wanandroid/widget/LoadMore.dart';

var httpClient = new HttpClient();

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('首页'),
      ),
      body: new HomeList(),
    );
  }

  const HomePage();
}

class HomeList extends StatefulWidget {
  @override
  _HomeListState createState() => new _HomeListState();
}

class _HomeListState extends State<HomeList> {
  int page = 0;
  List<HomeData> list = new List();
  var isRefresh = false;
  var isLoadMore = false;

  List<HomeBannerData> bannerList = new List();

  @override
  void initState() {
    super.initState();
    _loadData(0);
    _loadBanner();
  }

  @override
  Widget build(BuildContext context) {
    var content = new RefreshIndicator(
        child: new LoadMoreWidget(
          onLoadMore: loadmore,
          listView: new ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: _buildItem,
            itemCount: list.length,
          ),
        ),
        onRefresh: _refresh);
    return new Column(
      children: <Widget>[
        new SizedBox(
          height: 200.0,
          child: _buildBanner(),
        ),
        new Expanded(child: content),
      ],
    );
  }

  Widget _buildBanner() {
    return new SizedBox(
      child: new ListView.builder(
        itemBuilder: _buildBannerItem,
        scrollDirection: Axis.horizontal,
        itemCount: bannerList.length,
      ),
      height: 300.0,
    );
  }

  Widget _buildBannerItem(BuildContext context, int index) {
    var data = bannerList[index];
    return new SizedBox(
      width: 400.0,
      height: 300.0,
      child: new Image.network(data.imagePath),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    var data = list[index];
    return new ListTile(
      title: new Text(data.title),
      subtitle: new Text("作者:$data.author"),
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
