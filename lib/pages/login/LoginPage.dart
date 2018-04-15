import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/constants/Httpurl.dart';
import 'package:flutter_wanandroid/helper/HttpHelper.dart';
import 'package:flutter_wanandroid/helper/ScaffoldConvert.dart';
import 'package:flutter_wanandroid/helper/UserInfoHelper.dart';
import 'package:flutter_wanandroid/pages/login/RegisterPage.dart';
import 'package:flutter_wanandroid/widget/MyTextField.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin, ScaffoldConvert, HttpHelper {
  String user = "";
  String pwd = "";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('登录'),
        ),
        body: new Builder(builder: (ctx) {
          return _buildContent(ctx);
        }));
  }

  Widget _buildContent(BuildContext context) {
    var pwdNode = new FocusNode();
    bindScaffoldContext(context);
    return new Padding(
      padding: const EdgeInsets.only(left: 40.0, top: 80.0, right: 40.0),
      child: new Form(
        child: new Column(
          children: <Widget>[
            new TextField(
              onChanged: (str) {
                this.user = str;
              },
              decoration: new InputDecoration(
                labelText: '用户名',
                hintText: '英文/数字',
              ),
              maxLines: 1,
              onSubmitted: (text) {
                FocusScope.of(context).reparentIfNeeded(pwdNode);
              },
            ),
            new TextField(
              onChanged: (text) {
                this.pwd = text;
              },
              obscureText: true,
              maxLines: 1,
              decoration: new InputDecoration(hintText: '一般在6位以上', labelText: '密码'),
              keyboardType: TextInputType.text,
              onSubmitted: (text) {
                _submit();
              },
            ),
            createButton('登录', _submit),
            createButton('注册', _register),
          ],
        ),
      ),
    );
  }

  Widget createButton(String text, Function onTap) {
    return new Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: new Align(
        alignment: Alignment.centerRight,
        child: new InkWell(
          onTap: onTap,
          child: new Text(
            text,
            style: new TextStyle(
              fontSize: 18.0,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (user.isEmpty) {
      showSnackBar("用户名不能为空");
      return;
    }
    if (pwd.isEmpty) {
      showSnackBar("用户名不能为空");
      return;
    }
    print("$user $pwd");
    request(HttpUrl.login, method: METHOD.POST, params: {"username": user, "password": pwd}).then((params) {
      handle(params, () {
        var data = params["data"];
        UserInfoHelper.userInfo = new UserInfo(uid: data["id"].toString(), username: data["username"]);
        Navigator.pop(context, '登陆成功');
      });
    });
  }

  void _register() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) {
      return new RegisterPage();
    })).then((text) {
      if (text is String) {
        showSnackBar(text);
      }
    });
  }
}
