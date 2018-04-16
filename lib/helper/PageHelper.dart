import 'package:flutter/material.dart';

class PageHelper<Data> {
  List<Data> datas = new List();
  int page = 0;
  var _init = false;
  var _offset = 0.0;

  bool handle(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      _offset = notification.metrics.extentBefore;
    }
    return false;
  }

  ScrollController createController() {
    return new ScrollController(initialScrollOffset: _offset);
  }

  void init(Function initFunction) {
    if (!_init) {
      initFunction();
      _init = true;
    }
  }

  int itemCount() {
    return datas.length;
  }

  void addData(List<Data> datas, {clear = false}) {
    if (clear) {
      this.page = 0;
    }
    this.datas.addAll(datas);
    this.page++;
  }
}