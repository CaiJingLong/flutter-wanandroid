import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/entity/HomeEntity.dart';
import 'package:flutter_wanandroid/helper/UserInfoHelper.dart';
import 'package:flutter_wanandroid/pages/login/LoginPage.dart';

abstract class LikePage extends UserInfoHelper {
  Future<bool> _like(HomeData data) async {
    return true;
  }

  Future<bool> like(BuildContext context, HomeData data) async {
    var islogin = await isLogin();
    if (!islogin) {
      Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) {
        return new LoginPage();
      })).then((result) {
        if (result) {
          _like(data);
        }
      });
      return true;
    }
    return false;
  }
}
