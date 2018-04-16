import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/constants/Httpurl.dart';
import 'package:flutter_wanandroid/entity/HomeEntity.dart';
import 'package:flutter_wanandroid/entity/TreeEntity.dart';
import 'package:flutter_wanandroid/helper/HttpHelper.dart';
import 'package:flutter_wanandroid/helper/JsonHelper.dart';
import 'package:flutter_wanandroid/helper/PageHelper.dart';
import 'package:flutter_wanandroid/helper/UserInfoHelper.dart';
import 'package:flutter_wanandroid/pages/LikePage.dart';
import 'package:flutter_wanandroid/pages/WebPage.dart';
import 'package:flutter_wanandroid/pages/main/HomePage.dart';
import 'package:flutter_wanandroid/widget/LoadMore.dart';

class SubTreePage extends StatefulWidget {
  final String name;

  final List<SubTreeEntity> subTreeEntity;

  SubTreePage(this.name, this.subTreeEntity);

  @override
  _SubTreePageState createState() => new _SubTreePageState();
}

class _SubTreePageState extends State<SubTreePage> with SingleTickerProviderStateMixin {
  TabController _ctl;
  List<PageHelper<HomeData>> pageHelpers = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (var _ in widget.subTreeEntity) {
      pageHelpers.add(new PageHelper());
    }
    _ctl = new TabController(length: widget.subTreeEntity.length, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _ctl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.name),
        bottom: new PreferredSize(
            child: new Center(
              child: new TabBar(
                tabs: _buildTitle(),
                controller: _ctl,
                isScrollable: true,
              ),
            ),
            preferredSize: new Size.fromHeight(40.0)),
      ),
      body: _buildPage(),
    );
  }

  Widget _buildPage() {
    List<Widget> list = new List();
    for (var i = 0; i < widget.subTreeEntity.length; i++) {
      var entity = widget.subTreeEntity[i];
      var helper = pageHelpers[i];
      list.add(new _SubPage(helper, entity.id));
    }

    return new DefaultTabController(length: widget.subTreeEntity.length, child: new TabBarView(children: list));
  }

  List<Widget> _buildTitle() {
    return widget.subTreeEntity.map((entity) {
      return new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Text(
          entity.name,
          style: new TextStyle(fontSize: 16.0),
        ),
      );
    }).toList();
  }
}

class _SubPage extends StatefulWidget {
  final PageHelper<HomeData> pageHelper;
  final int cid;

  _SubPage(this.pageHelper, this.cid);

  @override
  __SubPageState createState() => new __SubPageState();
}

class __SubPageState extends State<_SubPage> with WebPage, LikePage, HomeItem, HttpHelper, UserInfoHelper {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.pageHelper.init(() {
      _loadData(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new RefreshIndicator(
      onRefresh: _refresh,
      child: new LoadMore(
        child: new ListView.builder(
          itemBuilder: _buildItem,
        ),
        onLoadMore: _loadMore,
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    print("datas ${widget.pageHelper.datas} index = $index}");
    return buildHomeItem(context, widget.pageHelper.datas[index]);
  }

  void _loadData(int page) async {
    var string = await requestString(HttpUrl.subTreeList(page), params: {"cid": widget.cid.toString()});
    Map userMap = json.decode(string);
    var resp = new HomeEntity.fromJson(userMap);
    print(resp);
    widget.pageHelper.addData(resp.data.datas, clear: page == 0);
    setState(() {});
  }

  Future<Null> _refresh() async {
    return new Completer<Null>().future;
  }

  Future _loadMore() async {
    _loadData(widget.pageHelper.page);
    return new Completer().future;
  }
}
