import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wanandroid/helper/index.dart';
import 'package:flutter_wanandroid/other/HeroAnimation.dart';
import 'package:flutter_wanandroid/other/LogoApp.dart';
import 'package:flutter_wanandroid/pages/Index.dart';
import 'package:flutter_wanandroid/pages/index.dart';
import 'package:flutter_wanandroid/pages/login/LoginPage.dart';

class DrawerPage extends StatefulWidget {
  @override
  _DrawPageState createState() => new _DrawPageState();
}

class _DrawPageState extends State<DrawerPage>
    with ScaffoldHelper, UserInfoHelper, NavigatorHelper, CookieHelper, TickerProviderStateMixin {
  AnimationController controller;
  CurvedAnimation curve;

  @override
  void initState() {
    super.initState();
    bindUserInfoChanged(() {
      _refreshState();
    });
    _refreshState();

    controller = new AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    curve = new CurvedAnimation(parent: controller, curve: Curves.easeIn);

    controller.forward();
  }

  String username = "";
  var _isLogin = false;

  _refreshState() async {
    var username = await getUserName();
    var login = await isLogin();
    setState(() {
      this.username = username;
      this._isLogin = login;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    controller = null;
    curve = null;
    super.dispose();
    unbindUserInfoChanged();
  }

  @override
  Widget build(BuildContext context) {
    var subHeader = new FadeTransition(
      opacity: curve,
      child: new InkWell(
        child: new AspectRatio(
          aspectRatio: 30 / 15,
          child: new Material(
            child: new Column(
              children: <Widget>[
                new FlutterLogo(
                  size: 40.0,
                ),
                new Center(child: new Text(username)),
                _buildLoginButton(),
              ],
            ),
          ),
        ),
      ),
    );
    return new Drawer(
        child: new Scaffold(
      appBar: new AppBar(
        title: new Title(
          child: new Text('菜单'),
          color: Colors.white,
        ),
      ),
      body: new Builder(builder: (ctx) {
        bindScaffoldContext(ctx);
        return new Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: new ListView(
            children: [
              subHeader,
              new Divider(),
              createItem('我的收藏', () {
                if (_isLogin) {
                  push(context, new CollectionPage());
                } else {
                  _goLogin();
                }
              }),
              new Divider(),
              createItem('关于项目', () {
                var dialog = createAboutDialog();
                showDialog(
                    context: ctx,
                    builder: (ctx) {
                      return dialog;
                    });
              }),
              new Divider(),
              createItem('about flutter', () {
                showAboutDialog(context: ctx);
              }),
//              new Divider(),
//              createItem('实验性', () {
//                push(context, new LogoApp());
//              }),
//              new Divider(),
//              new Divider(),
//              createItem('实验性2', () {
//                push(context, new RadialExpansionDemo());
//              }),
//              new Divider(),
            ],
          ),
        );
      }),
    ));
  }

  Widget createItem(String text, Function onTap) {
    return new InkWell(
      onTap: onTap,
      child: new Align(
        child: new Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Text(
            text,
            style: new TextStyle(fontSize: 16.0),
          ),
        ),
        alignment: Alignment.center,
      ),
    );
  }

  Widget _buildLoginButton() {
    return new Padding(
      padding: const EdgeInsets.all(10.0),
      child: new Align(
        alignment: Alignment.centerRight,
        child: new SizedBox(
          child: new InkWell(
            child: new Text(
              _isLogin ? "登出" : "登录",
              style: new TextStyle(
                color: Colors.blue,
                fontSize: 18.0,
              ),
            ),
            onTap: () {
              if (!_isLogin) {
                _goLogin();
              } else {
                UserInfoHelper.logout();
                clearCookies();
              }
            },
          ),
        ),
      ),
    );
  }

  _goLogin() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) {
      return new LoginPage();
    })).then((text) {
      if (text is String) {
        showSnackBar(text);
        _refreshState();
      }
    });
  }
}
