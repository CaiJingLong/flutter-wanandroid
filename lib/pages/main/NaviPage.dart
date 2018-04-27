import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_wanandroid/index.dart';

class NaviPage extends StatelessWidget {
  final PageHelper<NaviData> pageHelper;

  @override
  Widget build(BuildContext context) {
    return new _NaviPage(pageHelper);
  }

  NaviPage(this.pageHelper);
}

class _NaviPage extends StatefulWidget {
  final PageHelper<NaviData> pageHelper;

  _NaviPage(this.pageHelper);

  @override
  _NaviPageState createState() => new _NaviPageState();
}

class _NaviPageState extends State<_NaviPage> with HttpHelper, WebPage {
  @override
  void initState() {
    super.initState();
    widget.pageHelper.init(() {
      _loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new NotificationListener(
      onNotification: widget.pageHelper.handle,
      child: new ListView.builder(
        itemBuilder: _buildItem,
        controller: widget.pageHelper.createController(),
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: widget.pageHelper.itemCount(),
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    var data = widget.pageHelper.datas[index];

    return new Column(
      children: <Widget>[
        new Padding(
          padding: const EdgeInsets.all(16.0),
          child: new Align(
            child: new Text(
              data.name,
              style: new TextStyle(
                fontSize: 16.0,
              ),
            ),
            alignment: Alignment.centerLeft,
          ),
        ),
        new Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Align(
            alignment: Alignment.topLeft,
            child: new Wrap(
              children: _createWidget(data.articles),
              runSpacing: 8.0,
              spacing: 8.0,
            ),
          ),
        ),
        new Divider(
          height: 1.0,
          color: Colors.grey,
        ),
      ],
    );
  }

  void _loadData() async {
    var string = await requestString(HttpUrl.navi);

    var userMap = json.decode(string);
    var resp = new NaviEntity.fromJson(userMap);

    widget.pageHelper.addData(resp.data);
    setState(() {});
  }

  List<Widget> _createWidget(List<NaviChildData> articles) {
    return articles.map((data) {
      return new InkWell(
        onTap: () {
          startUrl(data.link, context: context, title: data.title);
        },
        child: new Chip(
          label: new Text(data.title),
        ),
      );
    }).toList();
  }
}
