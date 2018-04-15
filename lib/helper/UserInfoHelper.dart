abstract class UserInfoHelper {
  static UserInfo userInfo;

  String getUid() {
    return userInfo.uid;
  }

  bool isLogin() {
    return UserInfoHelper.userInfo != null;
  }

  String getUserName() {
    return isLogin() ? UserInfoHelper.userInfo.username : "未登录";
  }

  void logout(){
    userInfo = null;
  }
}

class UserInfo {
  String uid;

  String username;

  UserInfo({this.uid, this.username});
}
