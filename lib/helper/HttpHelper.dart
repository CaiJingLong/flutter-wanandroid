import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_wanandroid/helper/index.dart';

const _baseUrl = "www.wanandroid.com";
final HttpClient _client = new HttpClient();

enum METHOD { POST, GET, PUT, DELETE }

class _CookieHelper extends CookieHelper {}

abstract class HttpHelper {
  CookieHelper cookieHelper = new _CookieHelper();

  Future<Map<String, dynamic>> requestParams(String path,
      {METHOD method = METHOD.GET, Map<String, String> params, Map<String, String> headers}) async {
    var string = await requestString(path, method: method, params: params);
    var map = await json.decode(string);
    return map;
  }

  Future<String> requestString(String path, {METHOD method = METHOD.GET, Map<String, String> params, Map<String, String> headers}) async {
    HttpClientRequest request;
    var uri = new Uri.http(_baseUrl, path, params);
    switch (method) {
      case METHOD.GET:
        request = await _client.getUrl(uri);
        break;
      case METHOD.POST:
        request = await _client.postUrl(uri);
        break;
      case METHOD.PUT:
        request = await _client.putUrl(uri);
        break;
      case METHOD.DELETE:
        request = await _client.deleteUrl(uri);
        break;
    }

    var cookies = request.cookies;
    var list = await cookieHelper.getCookieList();
    cookies.addAll(list);

    var response = await request.close();
    var json = await response.transform(UTF8.decoder).join();

    await cookieHelper.addCookieList(response.cookies);

    return json;
  }

  Future<Map<String, dynamic>> handleParams(Map<String, dynamic> params) async {
    if (params["errorCode"] == -1) {
      throw new CodeError(params["errorMsg"]);
    } else {
      return params;
    }
  }

  Future<dynamic> handle(Map<String, dynamic> params) async {
    if (params["errorCode"] == -1) {
      return params["errorMsg"];
    } else {
      return params;
    }
  }
}

class CodeError extends Error {
  String msg;

  CodeError(this.msg);
}
