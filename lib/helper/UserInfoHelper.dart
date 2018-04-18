import 'dart:async';

import 'package:flutter/material.dart';
import 'CookieHelper.dart';

abstract class UserInfoHelper {
  static UserInfo userInfo;

  static List<ValueChanged<UserInfo>> valueChangedList = [];

  static void setUserInfo(UserInfo userInfo) {
    UserInfoHelper.userInfo = userInfo;

    for (var valueChanged in valueChangedList) {
      valueChanged(userInfo);
    }
  }

  ValueChanged<UserInfo> _changed;

  void bindUserInfoChanged(Function valueChanged) {
    _changed = (UserInfo userInfo) {
      valueChanged();
    };
    valueChangedList.add(_changed);
  }

  void unbindUserInfoChanged() {
    valueChangedList.remove(_changed);
  }

  static void logout() {
    setUserInfo(null);
  }

  String getUid() {
    return userInfo.uid;
  }

  var helper = new _CookieHelper();

  Future<bool> isLogin() async {
    var result = await helper.getSavedNameCookie();
    return result != null;
  }

  Future<String> getUserName() async {
    var login = await isLogin();
    var name = await helper.getSavedNameCookie();
    return login ? name.value : "未登录";
  }
}

class _CookieHelper extends CookieHelper {}

class UserInfo {
  String uid;

  String username;

  UserInfo({this.uid, this.username});
}
