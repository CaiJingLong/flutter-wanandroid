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
  List<Data> list = new List();
  var isRefresh = false;
  var isLoadMore = false;

  @override
  void initState() {
    super.initState();
    _loadData(0);
  }

  @override
  Widget build(BuildContext context) {
    var result = new RefreshIndicator(
        child: new LoadMoreWidget(
          onLoadMore: loadmore,
          listView: new ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: _buildItem,
            itemCount: list.length,
          ),
        ),
        onRefresh: _refresh);
    return result;
  }

  Widget _buildItem(BuildContext context, int index) {
    var data = list[index];
    return new Text('${data.title}');
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
}
