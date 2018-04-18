import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/index.dart';

class CollectionPage extends StatefulWidget {
  @override
  _CollectionPageState createState() => new _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> with HttpHelper {
  PageHelper<HomeData> _pageHelper = new PageHelper();

  List<HomeData> _datas;

  @override
  void initState() {
    super.initState();
    _datas = _pageHelper.datas;
    _pageHelper.init(() {
      _loadData(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('我的收藏'),
      ),
      body: new RefreshWidget(
        child: new ListView.builder(
          itemBuilder: _buildItem,
          controller: _pageHelper.createController(),
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: _datas.length,
        ),
        onLoadMore: _loadMore,
        onRefresh: _refresh,
        scrollHelper: _pageHelper,
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    var data = _datas[index];
    return new Text(data.title);
  }

  void _loadData(int page) async {
    var string = await requestString(HttpUrl.myCollectionList(page));
    var userMap = json.decode(string);
    var resp = new HomeEntity.fromJson(userMap);

    if (page == 0) {
      _pageHelper.page = 0;
    }
    _pageHelper.addData(resp.data.datas, clear: page == 0);
    _pageHelper.page++;
    _pageHelper.isFinish = resp.data.datas.isEmpty;

    setState(() {});
  }

  Future<Null> _refresh() async {
    _loadData(0);
  }

  Future _loadMore() async {
    _loadData(_pageHelper.page);
  }
}
