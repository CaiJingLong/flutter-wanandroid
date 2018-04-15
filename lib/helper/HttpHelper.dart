import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_wanandroid/helper/ScaffoldConvert.dart';

const _baseUrl = "www.wanandroid.com";
final HttpClient _client = new HttpClient();

enum METHOD { POST, GET, PUT, DELETE }

abstract class HttpHelper extends ScaffoldConvert {
  Future<Map<String, dynamic>> request(String path, {METHOD method = METHOD.GET, Map<String, String> params}) async {
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
    var map = JSON.decode(json);
    return map;
  }

  void handle(Map<String, dynamic> params, Function success) {
    if (params["errorCode"] == 0) {
      success();
    } else {
      this.showSnackBar(params["errorMsg"]);
    }
  }
}

class CodeError extends Error {
  String msg;

  CodeError(this.msg);
}
