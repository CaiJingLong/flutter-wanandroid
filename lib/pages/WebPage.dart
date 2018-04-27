import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

abstract class WebPage {
  static const platform = const MethodChannel('com.github.caijinglong.flutterwanandroid');

  void startUrl(String url, {BuildContext context, String title, PreferredSizeWidget appbar}) {
    if (context == null) {
      platform.invokeMethod("starturl", url);
    } else {
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (ctx) => new WebviewScaffold(
                url: url,
                appBar: appbar == null ? new AppBar(title: new Text(title == null ? "" : title)) : appbar,
              )));
    }
  }
}
