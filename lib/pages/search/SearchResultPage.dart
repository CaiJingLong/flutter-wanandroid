import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/index.dart';

class SearchResultPage extends StatefulWidget {
  final String searchText;

  SearchResultPage(this.searchText);

  @override
  _SearchResultPageState createState() => new _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> with NavigatorHelper, HttpHelper, HomeItem, UserInfoHelper, LikePage, WebPage {
  List<String> textList = new List<String>();

  PageHelper<HomeData> pageHelper = new PageHelper();

  @override
  void initState() {
    super.initState();
    var text = widget.searchText.replaceAll("　", " ").trim(); //替换全角空格为英文空格
    textList = text.split(" ");
    textList.remove(" ");

    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('搜索结果'),
      ),
      body: new Column(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: _createTagList(),
            ),
          ),
          new Expanded(
            child: new RefreshWidget(
              onLoadMore: _loadMore,
              onRefresh: _refresh,
              scrollHelper: pageHelper,
              child: new ListView.builder(
                itemBuilder: _buildListItem,
                itemCount: pageHelper.itemCount(),
                physics: const AlwaysScrollableScrollPhysics(),
                controller: pageHelper.createController(),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _createTagList() {
    return textList.map((String text) {
      return _buildTag(text);
    }).toList();
  }

  Widget _buildTag(String text) {
    return new Chip(
      label: new Text(text),
      onDeleted: () {
        textList.remove(text);
        if (textList.isEmpty) {
          pop(context);
          return;
        }
        setState(() {});
      },
    );
  }

  Future _loadData(int page) async {
    var k = "";
    textList.forEach((text) {
      k += text;
      k += " ";
    });

//    print("k = $k");

    var string = await requestString(HttpUrl.search(page), method: METHOD.POST, params: {"k": k});

    var userMap = json.decode(string);

    handleParams(userMap).catchError((err) {
      print(err);
    });

    var resp = new HomeEntity.fromJson(userMap);

    if (page == 0) {
      pageHelper.page = 0;
    }

    pageHelper.addData(resp.data.datas, clear: page == 0);

    setState(() {});
  }

  Widget _buildListItem(BuildContext context, int index) {
    var data = pageHelper.datas[index];
    return buildHomeItem(context, data);
  }

  Future<Null> _refresh() async {
    _loadData(0);
  }

  Future _loadMore() async {
    await _loadData(pageHelper.page);
  }
}
