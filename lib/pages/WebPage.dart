import 'package:flutter/services.dart';

abstract class WebPage {
  static const platform = const MethodChannel('com.github.caijinglong.flutterwanandroid');

  void startUrl(String url) {
    platform.invokeMethod("starturl", url);
  }
}
