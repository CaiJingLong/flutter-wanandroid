import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_wanandroid/helper/ScaffoldConvert.dart';

const _baseUrl = "www.wanandroid.com";
final HttpClient _client = new HttpClient();

enum METHOD { POST, GET, PUT, DELETE }

abstract class HttpHelper {
  Future<Map<String, dynamic>> requestParams(String path, {METHOD method = METHOD.GET, Map<String, String> params}) async {
    var string = await requestString(path, method: method, params: params);
    var map = await json.decode(string);
    return map;
  }

  Future<String> requestString(String path, {METHOD method = METHOD.GET, Map<String, String> params}) async {
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

    var response = await request.close();
    var json = await response.transform(UTF8.decoder).join();
    return json;
  }

  Future<Map<String, dynamic>> handle(Map<String, dynamic> params) async {
    if (params["errorCode"] == 0) {
      throw new CodeError(params["errorMsg"]);
    } else {
      return params;
    }
  }
}

class CodeError extends Error {
  String msg;

  CodeError(this.msg);
}
