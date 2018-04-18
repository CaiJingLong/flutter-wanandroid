import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_wanandroid/helper/index.dart';

abstract class CookieHelper {
  SimpleSaveHelper _simpleSaveHelper = SimpleSaveHelper.instance;
  static final key = "cookies";
  static final userKey = "loginUserName";
  static final pwdKey = "loginUserPassword";

  Future<Map<String, Cookie>> getCookies() async {
    var string = await _simpleSaveHelper.getString(key);
    if (string == null || string.isEmpty || string.trim() == "{}") {
      return emptyParams();
    }
    Map<String, dynamic> map = json.decode(string);
    var result = emptyParams();

    map.forEach((key, value) {
      result[key] = new Cookie(key, value["value"]);
    });

    return result;
  }

  Future<List<Cookie>> getCookieList() async {
    var cookies = await getCookies();
    return cookies.values.toList();
  }

  void _saveCookies(Map<String, Cookie> cookies) async {
    var map = new Map<String, _MyCookie>();
    cookies.forEach((key, value) {
      map[key] = _convertCookieToMy(value);
    });
    _simpleSaveHelper.putString(key, json.encode(map));
  }

  _MyCookie _convertCookieToMy(Cookie cookie) {
    var name = cookie.name;
    var value = cookie.value;
    return new _MyCookie(name, value);
  }

  Cookie _convertMyCoolieToCookie(_MyCookie jsonString) {
    return new Cookie();
  }

  Future<Null> saveCookieList(List<Cookie> list) async {
    var map = emptyParams();
    for (var value in list) {
      map[value.name] = value;
    }
    _saveCookies(map);
  }

  Future<Null> addCookieList(List<Cookie> list) async {
    var map = emptyParams();
    for (var value in list) {
      map[value.name] = value;
    }
    var cookieMap = await getCookies();
    cookieMap.addAll(map);
    _saveCookies(cookieMap);
  }

  void setCookie(String key, Cookie value) async {
    var cookies = await getCookies();
    cookies[key] = value;
    _saveCookies(cookies);
  }

  void removeCookie(String key) async {
    var cookies = await getCookies();
    cookies.remove(key);
    _saveCookies(cookies);
  }

  void clearCookies() async {
    _saveCookies(emptyParams());
  }

  Future<Cookie> getSavedNameCookie() async {
    var map = await getCookies();
    return map[userKey];
  }

  Future<Cookie> getSavedPwd() async {
    var map = await getCookies();
    return map[pwdKey];
  }

  Map<String, Cookie> emptyParams() => new Map<String, Cookie>();
}

class _MyCookie {
  String name;
  String value;

  _MyCookie(this.name, this.value);

  _MyCookie.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        value = json["value"];

  Map<String, dynamic> toJson() => {
        'name': name,
        'value': value,
      };
}
