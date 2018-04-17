import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/helper/index.dart';
import 'index.dart';

class SearchIndexPage extends StatefulWidget {
  @override
  _SearchIndexPageState createState() => new _SearchIndexPageState();
}

class _SearchIndexPageState extends State<SearchIndexPage> with NavigatorHelper, ScaffoldHelper {
  String _input = "";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new TextField(
          decoration: new InputDecoration(hintText: '多个关键字以空格分开'),
          onChanged: _onInputChanged,
          onSubmitted: _onSubmit,
        ),
        actions: <Widget>[
          new Builder(
            builder: (ctx) {
              bindScaffoldContext(ctx);
              return new IconButton(
                icon: new Icon(Icons.search),
                onPressed: _onSearch,
              );
            },
          )
        ],
      ),
    );
  }

  void _onSubmit(String value) {
    _onSearch();
  }

  void _onSearch() {
    if (_input == null || _input.trim().length == 0) {
      showSnackBar("搜索关键字不能为空");
      return;
    }
    push(context, new SearchResultPage(_input));
  }

  void _onInputChanged(String value) {
    _input = value;
  }
}
