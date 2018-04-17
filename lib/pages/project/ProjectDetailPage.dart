import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/index.dart';

class ProjectDetailPage extends StatefulWidget {
  final int cid;

  final String name;

  ProjectDetailPage(this.cid, this.name);

  @override
  _ProjectDetailPageState createState() => new _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> with HttpHelper, PushHelper {
  PageHelper<SubProjectData> _helper = new PageHelper();

  @override
  void initState() {
    super.initState();
    _loadData(0);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.name),
      ),
      body: new RefreshWidget(
        onRefresh: _refresh,
        child: new ListView.builder(
          itemBuilder: _buildItem,
          controller: _helper.createController(),
          itemCount: _helper.itemCount(),
          physics: const AlwaysScrollableScrollPhysics(),
        ),
        scrollHelper: _helper,
        onLoadMore: _loadMore,
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    var data = _helper.datas[index];

    return new InkWell(
      onTap: () {
        push(context, new _DetailPage(data));
      },
      child: new Container(
        decoration: new BoxDecoration(
          border: new Border(
            bottom: new BorderSide(
              color: Theme.of(context).dividerColor,
            ),
          ),
        ),
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new ListTile(
                title: new Text(data.title),
                subtitle: new Text(data.desc),
              ),
            ),
            new Align(
              alignment: Alignment.centerRight,
              child: new Icon(
                Icons.keyboard_arrow_right,
                color: Colors.blue,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _loadData(int page) async {
    var string = await requestString(HttpUrl.subProject(page), params: {"cid": widget.cid.toString()});

    var userMap = json.decode(string);
    var resp = new SubProjectResponse.fromJson(userMap);

    _helper.addData(resp.data.datas, clear: page == 0);
    _helper.page++;

    _helper.isFinish = resp.data.curPage >= resp.data.pageCount;
    setState(() {});
  }

  Future<Null> _refresh() async {
    _loadData(0);
  }

  Future _loadMore() async {
    _loadData(_helper.page);
  }
}

class _DetailPage extends StatefulWidget {
  final SubProjectData data;

  _DetailPage(this.data);

  @override
  __DetailPageState createState() => new __DetailPageState();
}

class __DetailPageState extends State<_DetailPage> with WebPage {
  SubProjectData data;

  @override
  void initState() {
    super.initState();
    this.data = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(data.title),
      ),
      body: new ListView(
        children: <Widget>[
          new AspectRatio(
            child: new Image.network(data.envelopePic),
            aspectRatio: 1.0,
          ),
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Text(
              data.title,
              style: new TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Text(data.desc),
          ),
          new MyDivider(),
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Text('项目介绍'),
          ),
          new FlatButton(
            child: new Text(data.link),
            onPressed: () {
              startUrl(data.link);
            },
          ),
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Text(
              '项目地址',
            ),
          ),
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new FlatButton(
              child: new Text(data.projectLink),
              onPressed: () {
                startUrl(data.projectLink);
              },
            ),
          ),
        ],
      ),
    );
  }
}
