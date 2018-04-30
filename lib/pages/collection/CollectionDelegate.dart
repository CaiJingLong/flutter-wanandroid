import 'dart:async';

import 'package:flutter_wanandroid/index.dart';

abstract class CollectionDelegate extends Object with HttpHelper {
  Future<bool> collectionInside(int id) async {
    var params = await requestParams(HttpUrl.collectionInside(id), method: METHOD.POST);

    _handlerParams(params);

    return true;
  }

  Future<bool> collectionOutSide(String title, String author, String link) async {
    var params =
        await requestParams(HttpUrl.collectionOutside, method: METHOD.POST, params: {"title": title, "author": author, "link": link});

    _handlerParams(params);

    return true;
  }

  Future<bool> cancelCollectionWithId(int id) async {
    var params = await requestParams(HttpUrl.cancelCollectionId(id), method: METHOD.POST);
    _handlerParams(params);

    return true;
  }

  Future<bool> cancelCollectionWithCollectionList(int id, {int originId = -1}) async {
    var params = await requestParams(HttpUrl.cancelCollectionIdCollectPage(id),
        method: METHOD.POST, params: {"id": id.toString(), "originId": originId.toString()});
    _handlerParams(params);
    return true;
  }

  _handlerParams(Map<String, dynamic> params) {
    if (params["errorCode"] != 0) {
      throw CodeError(params["errorMsg"]);
    }
  }
}
