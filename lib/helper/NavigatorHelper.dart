import 'dart:async';

import 'package:flutter/material.dart';

abstract class NavigatorHelper {
  Future push(BuildContext context, Widget widget) {
    return Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) {
      return widget;
    }));
  }

  pop(BuildContext context, {result}) {
    Navigator.of(context).pop(result);
  }

  showDialog(BuildContext ctx,Widget widget){
  }
}
