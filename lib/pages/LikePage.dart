import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/constants/Httpurl.dart';
import 'package:flutter_wanandroid/entity/HomeEntity.dart';
import 'package:flutter_wanandroid/helper/HttpHelper.dart';
import 'package:flutter_wanandroid/helper/UserInfoHelper.dart';
import 'package:flutter_wanandroid/pages/login/LoginPage.dart';

abstract class LikePage extends UserInfoHelper with HttpHelper {
  Future<bool> _like(HomeData data) async {
    if (data.collect == true) { //为true则取消
      var params = await requestParams(HttpUrl.cancelCollectionId(data.id), method: METHOD.POST);
      if (_check(params)) {
        data.collect = false;
        return true;
      }
      return false;
    } else { // false 则收藏
      var params = await requestParams(HttpUrl.collectionInside(data.id), method: METHOD.POST);
      if (_check(params)) {
        data.collect = true;
        return true;
      }
      return false;
    }
  }

  bool _check(Map<String, dynamic> params) {
    return params["errorCode"] == 0;
  }

  Future<bool> like(BuildContext context, HomeData data) async {
    var islogin = await isLogin();
    if (!islogin) {
      var loginResult = await Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) {
        return new LoginPage();
      }));
      if (loginResult) {
        var likeResult = await _like(data);
        return likeResult;
      }
      return false;
    }
    var likeResult = await _like(data);
    return likeResult;
  }
}
