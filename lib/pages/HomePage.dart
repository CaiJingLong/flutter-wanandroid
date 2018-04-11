import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/entity/HomeEntity.dart';
import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

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

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemBuilder: _buildItem,
      itemCount: list.length,
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    var data = list[index];
    return new Text('${data.title}');
  }

  void _loadData() async {
    var uri = new Uri.http("www.wanandroid.com", "article/list/$page/json");
    var request = await httpClient.getUrl(uri);
    var response = await request.close();
    var json = await response.transform(UTF8.decoder).join();

    Map userMap = JSON.decode(json);
    var resp = new HomeEntity.fromJson(userMap);

    if (resp.data.curPage == 1) {
      list.clear();
    }
    list.addAll(resp.data.datas);

    setState(() {});
  }
}
