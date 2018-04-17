import 'package:flutter/material.dart';

abstract class PushHelper {
  push(BuildContext context, Widget widget) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) {
      return widget;
    }));
  }
}
