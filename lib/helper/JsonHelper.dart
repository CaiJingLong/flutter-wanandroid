import 'dart:convert';

abstract class JsonHelper {
  static dynamic getData(jsonString) {
    return json.decode(jsonString)["data"];
  }
}
