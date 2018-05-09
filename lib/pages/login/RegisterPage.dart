import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/constants/Httpurl.dart';
import 'package:flutter_wanandroid/helper/HttpHelper.dart';
import 'package:flutter_wanandroid/helper/NavigatorHelper.dart';
import 'package:flutter_wanandroid/helper/ScaffoldHelper.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => new _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with ScaffoldHelper, HttpHelper, NavigatorHelper {
  String user;

  String pwd;

  String repwd;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('注册'),
        ),
        body: new Builder(builder: (ctx) {
          return _buildContent(ctx);
        }));
  }

  Widget _buildContent(BuildContext ctx) {
    bindScaffoldContext(ctx);
    var pwdNode = new FocusNode();
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
              onSubmitted: (text) {},
            ),
            new TextField(
              onChanged: (text) {
                this.repwd = text;
              },
              obscureText: true,
              maxLines: 1,
              decoration: new InputDecoration(hintText: '重复密码', labelText: '密码'),
              keyboardType: TextInputType.text,
              onSubmitted: (text) {
                register();
              },
            ),
            createButton('注册', register),
          ],
        ),
      ),
    );
  }

  Future register() async {
    if (user == null || user.isEmpty) {
      showSnackBar("用户名不能为空");
      return;
    }

    if (pwd == null || pwd.isEmpty) {
      showSnackBar("密码不能为空");
      return;
    }

    if (repwd == null || repwd.isEmpty) {
      showSnackBar("重复密码不能为空");
      return;
    }

    if (pwd != repwd) {
      showSnackBar("两次密码不一致");
      return;
    }

    var params = await requestParams(HttpUrl.register, method: METHOD.POST, params: {
      "username": user,
      "password": pwd,
      "repassword": repwd,
    });

    handleParams(params).then((params) {
      pop(context, result: "注册成功");
    }, onError: (err) {
      showErrorSnackBar(err);
    });
  }

  createButton(String text, Function onTap) {
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
}
