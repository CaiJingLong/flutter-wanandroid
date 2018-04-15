import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/helper/HttpHelper.dart';

abstract class ScaffoldConvert {
  BuildContext scaffoldBuildContext;

  void showSnackBar(String text, {int second = 3}) {
    var snakeBar = new SnackBar(
      content: new Text(text),
      duration: new Duration(seconds: second),
    );
    Scaffold.of(scaffoldBuildContext).showSnackBar(snakeBar);
  }

  void bindScaffoldContext(BuildContext context) {
    this.scaffoldBuildContext = context;
  }

  void showErrorSnackBar(Error error) {
    if (error is CodeError) {
      showSnackBar(error.msg);
    } else {
      print(error.stackTrace.toString());
      showSnackBar("未知错误");
    }
  }
}
