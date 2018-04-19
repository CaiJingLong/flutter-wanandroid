import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/constants/Httpurl.dart';
import 'package:flutter_wanandroid/entity/HomeEntity.dart';
import 'package:flutter_wanandroid/helper/HttpHelper.dart';
import 'package:flutter_wanandroid/helper/NavigatorHelper.dart';
import 'package:flutter_wanandroid/helper/PageHelper.dart';
import 'package:flutter_wanandroid/helper/ScaffoldHelper.dart';
import 'package:flutter_wanandroid/helper/UserInfoHelper.dart';
import 'package:flutter_wanandroid/pages/Index.dart';
import 'package:flutter_wanandroid/pages/LikePage.dart';
import 'package:flutter_wanandroid/pages/WebPage.dart';
import 'package:flutter_wanandroid/widget/LoadMore.dart';

var httpClient = new HttpClient();

HomeList _homeChild = new HomeList();

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _homeChild,
    );
  }

  const HomePage();
}

class HomeList extends StatefulWidget {
  @override
  _HomeListState createState() {
    return new _HomeListState();
  }
}

PageHelper _helper = new PageHelper<HomeData>();

List<HomeBannerData> _bannerList = new List();

int _currentPage = 0;

class _HomeListState extends State<HomeList>
    with WebPage, TickerProviderStateMixin, UserInfoHelper, HttpHelper, ScaffoldHelper, HomeItem, LikePage, NavigatorHelper {
  var isRefresh = false;
  var isLoadMore = false;

  TabController _bannerController;

  var timeout = const Duration(seconds: 4);

  Timer timer;

  @override
  void initState() {
    super.initState();
    _helper.init(() {
      _loadData(0);
      _loadBanner();
    });
    createTimer();
  }

  void createTimer() {
    timer = new Timer(timeout, _scrollBannerToNext);
  }

  @override
  void dispose() {
    super.dispose();
    _bannerController.dispose();
    timer.cancel();
  }

  _scrollBannerToNext() {
    createTimer();
    if (_bannerList.isEmpty) {
      return;
    }
    var next = _currentPage + 1;

    if (next >= _bannerList.length) {
      next = 0;
    }

    _bannerController.animateTo(next);
    _currentPage = next;
  }

  @override
  Widget build(BuildContext context) {
    var listView = new ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: _buildItem,
      itemCount: _helper.itemCount() + 1,
      controller: _helper.createController(),
    );

    var content = new RefreshWidget(
      onRefresh: _refresh,
      onLoadMore: loadMore,
      scrollHelper: _helper,
      child: listView,
    );
    return new Builder(builder: (ctx) {
      bindScaffoldContext(ctx);
      return content;
    });
  }

  Widget _buildBanner() {
    if (_bannerController != null) {
      _bannerController.dispose();
    }
    _bannerController = new TabController(
      vsync: this,
      length: _bannerList.length,
      initialIndex: _currentPage,
    );

    return new AspectRatio(
      aspectRatio: 3 / 1.7,
      child: new TabBarView(
        children: _bannerList.map(_buildBannerItem).toList(),
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

    var data = _helper.datas[index - 1];
    return buildHomeItem(context, data);
  }

  Future _loadData(int page) async {
    var string = await requestString(HttpUrl.getHomeList(page));
    print(string);

    Map userMap = json.decode(string);
    var resp = new HomeEntity.fromJson(userMap);

    var curPage = resp.data.curPage;
    if (curPage == 1) {
      _helper.page = 0;
      _helper.datas.clear();
    }
    _helper.datas.addAll(resp.data.datas);
    isLoadMore = false;
    isRefresh = false;
    _helper.page++;

    _helper.isFinish = resp.data.datas.isEmpty;

    setState(() {});
  }

  Future<Null> _refresh() async {
    _loadData(0);
  }

  Future<Null> loadMore() async {
    await _loadData(_helper.page);
  }

  void _loadBanner() async {
    var uri = new Uri.http("www.wanandroid.com", "banner/json");
    var request = await httpClient.getUrl(uri);
    var response = await request.close();
    var json = await response.transform(UTF8.decoder).join();

    Map userMap = JSON.decode(json);
    var resp = new HomeBannerEntity.fromJson(userMap);

    _bannerList.clear();
    _bannerList.addAll(resp.data);
    setState(() {});
  }
}

abstract class HomeItem extends WebPage with LikePage, NavigatorHelper {
  InkWell buildHomeItem(BuildContext context, HomeData data, {bool showDivider = true}) {
    var time = new DateTime.fromMillisecondsSinceEpoch(data.publishTime);
    var date = "${time.year}-${time.month}-${time.day}";

    return new InkWell(
      onTap: () {
        startUrl(data.link);
      },
      child: new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new SizedBox(
            height: 74.0,
            child: new Column(
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
                    new InkWell(
                      onTap: () {
                        like(context, data);
                      },
                      child: new Icon(data.collect ? Icons.star : Icons.star_border),
                    )
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
            )),
      ),
    );
  }
}
