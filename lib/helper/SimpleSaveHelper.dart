import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class SimpleSaveHelper {
  static SimpleSaveHelper instance = new SimpleSaveHelper();

  void putString(String key, String value) async {
    var _sp = await getSp();
    _sp.setString(key, value);
  }

  Future<SharedPreferences> getSp() => SharedPreferences.getInstance();

  Future<String> getString(String key) async {
    var sp = await getSp();
    return sp.getString(key);
  }
}
