import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/constants/Httpurl.dart';
import 'package:flutter_wanandroid/entity/HotEntity.dart';
import 'package:flutter_wanandroid/helper/HttpHelper.dart';
import 'package:flutter_wanandroid/pages/WebPage.dart';

class HotPage extends StatefulWidget {
  @override
  _HotPageState createState() => new _HotPageState();
}

class _HotPageState extends State<HotPage> with HttpHelper, WebPage {
  List<LinkEntity> _hotList = new List();
  List<LinkEntity> frientLinks = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadHot();
    loadFriendLink();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void loadHot() async {
    var json = await requestString(HttpUrl.hotkey);
    List<LinkEntity> datas = LinkEntity.decode(json);
    _hotList.addAll(datas);
    setState(() {});
  }

  void loadFriendLink() async {
    var json = await requestString(HttpUrl.friendLink);
    List<LinkEntity> datas = LinkEntity.decode(json);
    frientLinks.addAll(datas);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('常用'),
      ),
      body: new ListView(children: <Widget>[
        new Padding(
          padding: const EdgeInsets.all(16.0),
          child: new Text(
            '热搜',
            style: new TextStyle(fontSize: 16.0),
          ),
        ),
        new Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Wrap(
            spacing: 8.0, // gap between adjacent chips
            runSpacing: 8.0, // gap betwe
            children: _buildHotList(),
          ),
        ),
        new Padding(
          padding: const EdgeInsets.all(16.0),
          child: new Text(
            '常用网站',
            style: new TextStyle(fontSize: 16.0),
          ),
        ),
        new Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Wrap(
            spacing: 8.0, // gap between adjacent chips
            runSpacing: 8.0, // gap betwe
            children: _buildCommonWebList(),
          ),
        ),
      ]),
    );
  }

  List<Widget> _buildHotList() {
    return _buildList(_hotList, (LinkEntity data) {
      // TODO push to search
    });
  }

  List<Widget> _buildCommonWebList() {
    return _buildList(frientLinks, (LinkEntity data) {
      startUrl(data.link);
    });
  }

  List<Widget> _buildList(List<LinkEntity> list, Function click) {
    var widgets = new List<Widget>();
    for (var data in list) {
      widgets.add(new InkWell(
        child: new Chip(
          label: new Text(
            data.name,
            style: new TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
        ),
        onTap: () {
          click(data);
        },
      ));
    }
    return widgets;
  }
}

class HotDelegate extends FlowDelegate {
  @override
  void paintChildren(FlowPaintingContext context) {}

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return true;
  }
}

class WebDelegate extends FlowDelegate {
  @override
  void paintChildren(FlowPaintingContext context) {
    // TODO: implement paintChildren
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return true;
  }
}
