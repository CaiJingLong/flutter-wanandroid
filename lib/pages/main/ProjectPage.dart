import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/index.dart';

class ProjectPage extends StatelessWidget {
  final PageHelper<ProjectData> pageHelper;

  @override
  Widget build(BuildContext context) {
    return new _ProjectPage(pageHelper);
  }

  ProjectPage(this.pageHelper);
}

class _ProjectPage extends StatefulWidget {
  final PageHelper<ProjectData> pageHelper;

  _ProjectPage(this.pageHelper);

  @override
  __ProjectPageState createState() => new __ProjectPageState();
}

class __ProjectPageState extends State<_ProjectPage> with HttpHelper {
  @override
  void initState() {
    super.initState();
    widget.pageHelper.init(() {
      _loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemBuilder: (ctx, index) {
        var data = widget.pageHelper.datas[index];
        return new InkWell(
          onTap: () {
            Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) {
              return new ProjectDetailPage(data.id, data.name);
            }));
          },
          child: new Container(
            decoration: new BoxDecoration(
              border: new Border(
                bottom: new BorderSide(
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ),
            child: new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Stack(
                children: <Widget>[
                  new Text(
                    data.name,
                    style: new TextStyle(fontSize: 18.0),
                  ),
                  new Align(
                    alignment: Alignment.centerRight,
                    child: new Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: widget.pageHelper.itemCount(),
    );
  }

  void _loadData() async {
    var string = await requestString(HttpUrl.project);
    var userMap = json.decode(string);
    var resp = new ProjectEntity.fromJson(userMap);

    widget.pageHelper.addData(resp.data);

    setState(() {});
  }
}
