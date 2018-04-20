import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

var _githubLink = 'https://github.com/Caijinglong/flutter-wanandroid';

AlertDialog createAboutDialog() {
  var dialog = new AlertDialog(
    title: new Text('flutter版本'),
    content: new SizedBox(
      height: 110.0,
      child: new Scaffold(
        body: new Builder(
          builder: (ctx) {
            return new Column(
              children: <Widget>[
                new Text('作者:caijinglong'),
                new InkWell(
                  onTap: () {
                    Clipboard.setData(new ClipboardData(text: _githubLink));
                    Scaffold.of(ctx).showSnackBar(new SnackBar(content: new Text('项目地址已复制至剪切板')));
                  },
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text('项目地址:(点击复制)'),
                      new Text(_githubLink),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    ),
  );
  return dialog;
}
