class HttpUrl {

  /// username，password
  static var login = "user/login";

  /// username,password,repassword
  static var register = "user/register";

  // 友情链接
  static var friendLink = "friend/json";

  // 热词
  static var hotkey = "hotkey/json";

  // 体系
  static var tree = "tree/json";

  static String subTreeList(int page) {
    return "article/list/$page/json";
  }

}
