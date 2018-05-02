import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/index.dart';

class CollectionPage extends StatefulWidget {
  @override
  _CollectionPageState createState() => new _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage>
    with HttpHelper, WebPage, NavigatorHelper, LikePage, UserInfoHelper, CollectionDelegate {
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

  Widget buildHomeItem(BuildContext context, HomeData data, {bool showDivider = true}) {
    var time = new DateTime.fromMillisecondsSinceEpoch(data.publishTime);
    var date = "${time.year}-${time.month}-${time.day}";

    return new InkWell(
      onTap: () {
        startUrl(data.link, context: context, title: data.title);
//        launchURL(data.link);
      },
      onLongPress: () {
        showDialog(
          context: context,
          builder: (ctx) {
            return new AlertDialog(
              title: new Text('取消收藏?'),
              actions: <Widget>[
                new RaisedButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: new Text('取消'),
                ),
                new RaisedButton(
                  onPressed: () {
                    cancelCollection(data);
                    Navigator.pop(ctx);
                  },
                  child: new Text('确定'),
                ),
              ],
            );
          },
        );
      },
      child: new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new SizedBox(height: 74.0, child: buildColumn(data, date, context)),
      ),
    );
  }

  void cancelCollection(HomeData data) async {
    var result = await cancelCollectionWithCollectionList(data.id, originId: data.originId);
    if (result) {
      setState(() {
        _datas.remove(data);
      });
    }
  }

  Widget buildColumn(HomeData data, String date, BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Row(
          children: <Widget>[
            new Expanded(
              child: new Text(
                data.title.trim(),
                maxLines: 1,
                style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
            ),
            new Padding(
              padding: const EdgeInsets.only(left: 3.0),
              child: new Text(date),
            ),
          ],
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 3.0),
          child: new Text(
            "作者: ${data.author}",
            style: new TextStyle(fontSize: 14.0),
          ),
        ),
        new Row(
          children: <Widget>[
            new Expanded(
              child: new Align(
                child: new InkWell(
                  child: new Text(
                    data.chapterName,
                    style: new TextStyle(fontSize: 14.0, color: Colors.blue),
                  ),
                  onTap: () {
                    push(context, new SingleTreePage(data.chapterId, data.chapterName));
                  },
                ),
                alignment: Alignment.centerLeft,
              ),
            ),
          ],
        ),
        new Expanded(
          child: new Align(
            alignment: Alignment.bottomCenter,
            child: new Divider(
              height: 1.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return buildHomeItem(context, _datas[index]);
  }

  Future _loadData(int page) async {
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
    await _loadData(_pageHelper.page);
  }
}
