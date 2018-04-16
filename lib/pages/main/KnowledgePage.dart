import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/constants/Httpurl.dart';
import 'package:flutter_wanandroid/entity/TreeEntity.dart';
import 'package:flutter_wanandroid/helper/HttpHelper.dart';
import 'package:flutter_wanandroid/helper/JsonHelper.dart';
import 'package:flutter_wanandroid/pages/tree/SubTreePage.dart';

class KnowledgePage extends StatefulWidget {
  @override
  _KnowledgePageState createState() => new _KnowledgePageState();

  const KnowledgePage();
}

class _KnowledgePageState extends State<KnowledgePage> with HttpHelper {
  List<TreeEntity> datas = new List();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    var json = await requestString(HttpUrl.tree);
    var datas = TreeEntity.decode(json);
    this.datas.addAll(datas);
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView.builder(
        itemBuilder: _buildItem,
        itemCount: datas.length,
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    var data = datas[index];

    return new InkWell(
      onTap: () {
        Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) {
          return new SubTreePage(data.name, data.children);
        }));
      },
      child: new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Row(
          children: <Widget>[
            new Expanded(
                child: new Column(
              children: <Widget>[
                new Align(
                  child: new Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: new Text(
                      data.name,
                      style: new TextStyle(fontSize: 16.0),
                    ),
                  ),
                  alignment: Alignment.topLeft,
                ),
                new Align(
                  child: _buildWrap(data.children),
                  alignment: Alignment.topLeft,
                )
              ],
            )),
            new Icon(
              Icons.keyboard_arrow_right,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWrap(List<SubTreeEntity> children) {
    List<Widget> list = new List();
    for (var c in children) {
      var widget = new Chip(
        label: new Text(c.name),
        backgroundColor: Colors.transparent,
      );
      list.add(widget);
    }
    return new Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: list,
    );
  }
}
