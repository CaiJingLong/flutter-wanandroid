class HttpUrl {

  /// 首页列表
  ///
  static String getHomeList(int page){
    return "article/list/$page/json";
  }
  ///
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

  /// 收藏文章列表
  /// [page] is page
  static String myCollectionList(int page) {
    return "lg/collect/list/$page/json";
  }

  /// 收藏站内
  /// id
  /// post
  static String collectionIn(int id) {
    return "lg/collect/$id/json";
  }

  /// 收藏站外文章
  /// title，author，link
  /// post
  static String collectionOut = "lg/collect/add/json";

  /// 取消收藏
  /// 文章列表
  ///
  static String cancelCollectionId(int id) {
    return "lg/uncollect_originId/$id/json";
  }

  /// 取消收藏 收藏页面
  /// id:拼接在链接上
  ///	originId:列表页下发，无则为-1
  static String cancelCollectionIdCollectPage(int id) {
    return "lg/uncollect/$id/json";
  }

  /// 收藏网站
  /// post
  /// name,link
  static String collectionWeb = "lg/collect/addtool/json";

  /// 收藏网站列表
  static String getCollectionWebList = "lg/collect/usertools/json";

  /// 编辑网站
  /// post
  /// id,name,link
  static String updateCollectionWeb = "lg/collect/updatetool/json";


  /// 删除网站
  /// POST
  /// id
  static String deleteCollectionWeb = "lg/collect/deletetool/json";
}
