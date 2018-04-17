class HttpUrl {
  /// 登录
  /// username，password
  static var login = "user/login";

  /// 注册
  /// params : username,password,repassword
  static var register = "user/register";

  /// 友情链接
  static var friendLink = "friend/json";

  /// 热词
  static var hotkey = "hotkey/json";

  /// 体系
  static var tree = "tree/json";

  /// 获取子体系的页面
  /// params cid
  static String subTreeList(int page) {
    return "article/list/$page/json";
  }

  /// 导航
  static var navi = "navi/json";

  /// 项目
  static var project = "project/tree/json";

  /// 项目字列表
  /// params cid
  static String subProject(int page) {
    return "/project/list/$page/json";
  }

  /// 搜索
  /// params [k] is key
  static String search(int page) {
    return "article/query/$page/json";
  }
}
