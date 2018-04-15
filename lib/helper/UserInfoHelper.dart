import 'package:flutter/material.dart';

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

  bool isLogin() {
    return UserInfoHelper.userInfo != null;
  }

  String getUserName() {
    return isLogin() ? UserInfoHelper.userInfo.username : "未登录";
  }
}

class UserInfo {
  String uid;

  String username;

  UserInfo({this.uid, this.username});
}
